class Fundamental::Artifact < ActiveRecord::Base

  belongs_to :owner,       :class_name => "Fundamental::Character",  :foreign_key => "owner_id",      :inverse_of => :artifact

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :artifact

  belongs_to :location,    :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :artifact
  belongs_to :region,      :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :artifacts

  def self.create_at_location_with_type(location, type_id)
    Military::Army.create_npc(location, Random.rand(400..600))
    location.create_artifact({
      owner:    Fundamental::Character.find_by_id(1),
      region:   location.region,
      active:   false,
      type_id:  type_id
    })
  end
end
