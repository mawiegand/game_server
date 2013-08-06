class AddAutoJoinDisabledToFundamentalAlliance < ActiveRecord::Migration
  def up
    add_column :fundamental_alliances, :auto_join_disabled, :boolean, :default => false, :null => false
    
    Fundamental::Alliance.all.each do |alliance|
      alliance.auto_join_disabled = true
      alliance.save
    end
  end
  
  def down
    remove_column :fundamental_alliances, :auto_join_disabled    
  end
end
