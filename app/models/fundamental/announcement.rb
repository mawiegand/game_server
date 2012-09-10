class Fundamental::Announcement < ActiveRecord::Base

  has_many   :translations,   :class_name => "Fundamental::Announcement",     :foreign_key => "original_id", :inverse_of => :original
  belongs_to :original,       :class_name => "Fundamental::Announcement",     :foreign_key => "original_id", :inverse_of => :translations
  
  belongs_to :author,         :class_name => "Backend::User",                 :foreign_key => "user_id",     :inverse_of => :announcements

  validates  :original_id,    :uniqueness => {:scope => :locale, :allow_blank => true}

  def author_name
    author.nil?  ?   'team' : author.name
  end

end
