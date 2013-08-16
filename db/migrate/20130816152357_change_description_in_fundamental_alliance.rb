class ChangeDescriptionInFundamentalAlliance < ActiveRecord::Migration
  def up
    change_column :fundamental_alliances, :description, :text, :limit => nil 
  end

  def down
    change_column :fundamental_alliances, :description, :text, :limit => 255 
  end
end
