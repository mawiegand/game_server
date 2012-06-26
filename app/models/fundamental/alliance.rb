class Fundamental::Alliance < ActiveRecord::Base  
  
  has_many   :members,   :class_name => "Fundamental::Character",     :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :armies,    :class_name => "Military::Army",             :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :locations, :class_name => "Map::Location",              :foreign_key => "alliance_id"
  has_many   :regions,   :class_name => "Map::Region",                :foreign_key => "alliance_id"
  has_many   :shouts,    :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id", :order => "created_at DESC"

  belongs_to :leader,    :class_name => "Fundamental::Character",     :foreign_key => "leader_id"

  
  attr_accessible :name, :password, :description, :banner,                                           :as => :owner
  attr_accessible *accessible_attributes(:owner), :tag, :leader_id,                                  :as => :creator # fields accesible during creation
  attr_accessible *accessible_attributes(:creator), :alliance_queue_alliance_research_unlock_count,  :as => :staff
  attr_accessible *accessible_attributes(:staff),                                                    :as => :admin
  
  attr_readable :id, :tag, :name, :description, :banner, :owner_id, :created_at, :updated_at,        :as => :default 
  attr_readable *readable_attributes(:default), :alliance_queue_,                                    :as => :ally 
  attr_readable *readable_attributes(:ally), :password,                                              :as => :owner
  attr_readable *readable_attributes(:owner),                                                        :as => :staff
  attr_readable *readable_attributes(:staff),                                                        :as => :admin
  
  
  before_save :prevent_empty_password
  
  
  
  
  def self.create_alliance(tag, name, leader, role = :creator)
    raise ConflictError.new("this alliance tag is already used") unless Fundamental::Alliance.find_by_tag(tag).nil?
    raise InternalServerError.new('no leader specified') if leader.nil? || leader.id.nil?
    
    alliance = Fundamental::Alliance.new({
      tag:       tag,
      name:      name,
      leader_id: leader.id,
    }, :as => role);
    
    raise InternalServerError.new('could not create alliance') unless alliance.save
    alliance.add_character(leader)

    return alliance
  end
  
  def add_character(character)
    character.alliance_tag = self.tag
    character.alliance_id = self.id
    character.save
  end
  
  def remove_character(character)
    character.alliance_tag = nil
    character.alliance_id = nil
    character.save
  end
  
  private
  
    def prevent_empty_password 
      if self.password.nil?
        self.password = random_string(4)
      end
      true
    end
  
    def random_string(len = 4)
      chars = ('a'..'z').to_a + ('A'..'Z').to_a
      (0..(len-1)).collect { chars[Kernel.rand(chars.length)] }.join
    end 
  
end
