class AddColorToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :color, :integer, :default => :null
  end
end
