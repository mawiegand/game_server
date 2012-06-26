class Fundamental::Alliance < ActiveRecord::Base
  has_many :members, :class_name => "Fundamental::Character", :foreign_key => "alliance_id"
  has_many :armies, :class_name => "Military::Army", :foreign_key => "alliance_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "alliance_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "alliance_id"
  has_many :shouts, :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id", :order => "created_at DESC"
  
  before_save :prevent_empty_password
  
  def self.create_alliance(tag, name, leader)
    raise ConflictError.new("this alliance tag is already used") unless Fundamental::Alliance.find_by_tag(tag).nil?
    raise InternalServerError.new('no leader specified') if leader.nil? || leader.id.nil?
    
    alliance = Fundamental::Alliance.new({
      tag:       tag,
      name:      name,
      leader_id: leader.id,
    });
    
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
