class AddColorToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :color, :integer
  end
end
