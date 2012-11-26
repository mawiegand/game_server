class AddInvitationCodeToMapRegion < ActiveRecord::Migration
  def up
    add_column :map_regions, :invitation_code, :string
    
    Map::Region.all.each do |region|
      region.add_unique_invitation_code
      region.save
    end
  end
  
  def down
    remove_column :map_regions, :invitation_code
  end
end
