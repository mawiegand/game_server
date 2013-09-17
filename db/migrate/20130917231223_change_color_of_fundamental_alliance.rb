class ChangeColorOfFundamentalAlliance < ActiveRecord::Migration
  def change
    change_column :fundamental_alliances, :color, :integer
  end
end
