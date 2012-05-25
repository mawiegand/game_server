class Map::Location < ActiveRecord::Base
  
  belongs_to :region, :class_name => "Region", :foreign_key => "region_id"
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  

  has_many :armies, :class_name => "Military::Army", :foreign_key => "location_id"
  has_many :battles, :class_name => "Military::Battle", :inverse_of => :location
  has_one :settlement, :class_name => "Settlement::Settlement", :foreign_key => 'location_id', :inverse_of => :location


  def self.find_empty
    Map::Location.where("type_id = ?", 0).offset(Random.rand(Map::Location.where("type_id = ?", 0).count)).first
  end
  
  def garrison_army
    self.armies.each do |army|
      if army.garrison 
        return army
      end
    end
    
    return nil
  end
  
    
end
