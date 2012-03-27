class Map::Region < ActiveRecord::Base
  
  belongs_to :node, :class_name => "Node", :foreign_key => "node_id"
  has_many :locations, :class_name => "Location", :foreign_key => "region_id", :order => :slot, :dependent => :destroy
  has_many :armies, :class_name => "Military::Army", :foreign_key => "region_id"
  
  def recount_settlements
    self.count_settlements = self.locations.where('type_id == 2').count
    self.save
  end
  
end
