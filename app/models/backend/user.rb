require 'base64'
#
# THIS CODE IS COPIED FROM IDENTIY PROVIDER; SHOULD IMPLEMENT
# A GENERATOR FOR THIS?  
#
# For security reasons, plain-text passwords are *not* stored in 
# the database. Instead, the passwords are salted (to prevent
# attacks with rainbow tables) and hashed before storing them.
# User-sent passwords are salted and hashed in exactly the 
# same way and then compared to the stored hash; if both match
# we can assume the user has sent the correct password. 
#
# To make things secure and prevent several knwown attacks,
# the implementation has to make sure the following things:
# * salts are long enough and have high enough entropy
# * different salts are used for each user
# * the hashing function must be cryptographic
# * plain-text passwords must not be stored in log files!
#
# == Schema Information
#
# Table name: identities
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  salt               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  admin              :boolean(255)
#  staff              :boolean(255)
#
class Backend::User < ActiveRecord::Base

  has_many   :announcements,   :class_name => "Fundamental::Announcement",    :foreign_key => "user_id",          :inverse_of => :author
  has_many   :partner_sites,   :class_name => "Backend::PartnerSite",         :foreign_key => "backend_user_id",  :inverse_of => :partner
  
  attr_accessor :password
  
  attr_accessible :login, :firstname, :surname, :password, :password_confirmation,                        :as => :owner
  attr_accessible *accessible_attributes(:owner), :email, :admin, :staff, :partner,                       :as => :creator # fields accesible during creation
  attr_accessible :login, :firstname, :surname, :developer,                                               :as => :developer
  attr_accessible :login, :firstname, :surname, :deleted, :staff, :partner, :developer,                   :as => :staff
  attr_accessible *accessible_attributes(:staff), :email, :admin, :password, :password_confirmation,      :as => :admin
    
  attr_readable :login, :id, :admin, :staff, :partner,                                                    :as => :default 
  attr_readable *readable_attributes(:default), :created_at,                                              :as => :user
  attr_readable *readable_attributes(:user), :email, :firstname, :surname, :updated_at, :deleted,         :as => :owner
  attr_readable *readable_attributes(:user), :email, :firstname, :surname, :updated_at, :deleted,         :as => :developer
  attr_readable *readable_attributes(:owner), :salt,                                                      :as => :staff
  attr_readable *readable_attributes(:staff),                                                             :as => :admin
  
  @email_regex      = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  @login_regex   = /^[^\d\s]+[^\s]*$/i
  
  validates :email, :presence   => true,
                    :format     => { :with => @email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :login,     :length       => { :maximum => 20 },
                        :format       => { :with => @nickname_regex, :allow_blank => true },
                        :uniqueness   => { :case_sensitive => false, :allow_blank => true }
                    
  validates :password,  :presence     => true,
                        :confirmation => true,
                        :length       => { :within  => 8..40 },
                        :on           => :create
                       
  validates :password,  :confirmation => true,
                        :length       => { :within  => 8..40, :allow_blank => true },
                        :on           => :update
                       
  validates :firstname, :length       => { :maximum => 20 } 
  
  validates :surname,   :length       => { :maximum => 30 }
      
  default_scope :order => 'login ASC'
                       
  before_save :set_encrypted_password
  
  def self.find_by_id_or_login(user_identifier, options = {})
    options = { 
      :find_deleted => false,    # by default: don't return deleted users
    }.merge(options).delete_if { |key, value| value.nil? }  # merge 'over' default values
    
    user = Backend::User.find_by_id(user_identifier) if Backend::User.valid_id?(user_identifier)
    user = Backend::User.find(:first, :conditions => ["lower(login) = lower(?)", user_identifier]) if user.nil? && Backend::User.valid_login?(user_identifier)
    # article about a method to generate a case-insensitive dynamic finder to replace the
    # code above: http://devblog.aoteastudios.com/2009/12/add-case-insensitive-finders-by.html
    
    user = nil if user && user.deleted && options[:find_deleted] == false    #don't return delted users if not explicitly being told so
    
    return user
  end
  
  # checks a potentialPassword (plain-text) against the "stored"
  # password of the identity. This is done by salting and hashing
  # the potentialPassword in the same way as the real password
  # has been encrypted and stored in the database. 
  def has_password?(potentialPassword)
    encrypted_password == encrypt_password(potentialPassword)
  end
  
  # returns true, when the user has clicked on the validation link
  # in the email that has been sent to him.
  def activated?
    return !activated.nil?
  end
  
  # authenticates login (email or nickname) and password and 
  # returns an identity iff
  # * the login matches an email or nickname in the database
  # * the submittedPassword matches the password of that identity.
  # It returns nil otherwise.
  def self.authenticate(login, submittedPassword)
    return nil if login.blank? || submittedPassword.blank?    
    identity = find_by_email_and_deleted(login, false) if identity.nil?
    identity = find_by_login_and_deleted(login, false) if identity.nil? # user may have specified valid nickname?
    return nil if identity.nil?
    return identity if identity.has_password?(submittedPassword)
  end
  
  # authenticates the current user with the salt that has been
  # stored in his cookie. This method is needed for session 
  # tracking and permanent login (remember token) in order to not 
  # have to remember password and email for the session. 
  def self.authenticate_with_salt(id, cookie_salt)
    identity = find_by_id_and_deleted(id, false)
    return nil if identity.nil?
    return identity if identity.salt == cookie_salt
  end
  
  def self.valid_user_identifier?(user_identifier)
    self.valid_id?(user_identifier) || self.valid_login?(user_identifier)
  end
    
  def self.valid_id?(id)
    id.index(/^[1-9]\d*$/) != nil
  end
  
  def self.valid_login?(name)
    name.index(@login_regex) != nil    # does not start with digit, no whitespaces
  end
  
  # returns a string representation of the identities role
  def role_string
    return role.to_s
  end
  
  def role
    return :admin if admin
    return :staff if staff
    return :partner if partner
    return :user
  end
  
  # this is just a stub and most be replaced by an appropriate
  # implementation that tries to somehow return the correct
  # gender of the user.
  def gender?
    return :unknown
  end

  # returns the most informal address that could be constructed
  # from the known user data
  def address_informal(role = :default, fallback_to_email = true)
    hash = sanitized_hash(role)
    return hash[:login] unless hash[:login].blank?
    return hash[:firstname] unless hash[:firstname].blank?
    return hash[:email] if fallback_to_email && !hash[:email].blank?
    return address_role
  end
  
  # Returns the most formal address that could be constructed from the
  # known user data. Does contain a translated (and possibly gendered)
  # address-prefix (Mr. / Mrs.).
  def address_formal(fallback_to_email = true)
    return address_prefix + " #{surname}" unless surname.blank?
    return firstname unless firstname.blank?
    return login unless login.blank?
    return email if fallback_to_email
    return address_role
  end
  
  def gravatar_hash
    return Digest::MD5.hexdigest(email.strip.downcase)
  end
  
  def gravatar_url(options = {})
    options = { 
      :size => 100, 
      :default => :identicon,
    }.merge(options).delete_if { |key, value| value.nil? }  # merge 'over' default values
    
    GravatarImageTag::gravatar_url( email.strip.downcase, options )
  end  
  
  # Returns a string addressing the user according to his role
  # (user, admin, staff)
  def address_role 
    return I18n.translate('general.address.admin') if admin?
    return I18n.translate('general.address.staff') if staff?
    return I18n.translate('general.address.partner') if partner?
    return I18n.translate('general.address.user')
  end
  
  # Returns a gendered and translated address prefix (Mr. / Mrs.) 
  # matching the present user. If gender is unkown, returns something
  # in the line of "Mr. or Mrs. Lange".
  def address_prefix
    return I18n.translate('general.address.mr') if gender? == :male
    return I18n.translate('general.address.mrs') if gender? == :unknwon
    return I18n.translate('general.address.mrmrs') 
  end
  
  # generates a validation code for this identitie's email address.
  # The implementation relies on the identitie's salt to never change.
  # Since the identity's random-generated salt can not be deduced from 
  # other values of the identity, it can be used as validation-token.
  def validation_code
    str = "#{email}.#{salt}"  
    strb64 = Base64.encode64(str);   # Base 64 encoding just to make sure it can be part of an URL. No encryption neceesary!
    return strb64.gsub(/[\n\r ]/,'') # no line breaks and spaces...
  end

  # checks whether the given activation code matches the identity.
  def has_validation_code?(code)
    return validation_code().eql? code
  end
  
  
  private
    
    # create salt, if not already set, and set the encrypted
    # password by salting and encrypting the plain-text
    # password sent by the user.
    def set_encrypted_password
      self.salt = make_random_string if new_record? # salt will be created once for a new record
      if !password.blank?
        self.encrypted_password = encrypt_password(self.password)
      end
    end
    
    # combine password and salt and then call the encryption
    # function on the string.
    def encrypt_password(string)
      encrypt("#{self.salt}--#{string}")
    end
    
    # encrypt the given string using a cryptographic hash 
    # function
    def encrypt(string)
      Digest::SHA2.hexdigest(string)
    end  
    
    # create a random-string with len chars
    def make_random_string(len = 64)
      chars = ('a'..'z').to_a + ('A'..'Z').to_a
      (0..(len-1)).collect { chars[Kernel.rand(chars.length)] }.join
    end    
end

