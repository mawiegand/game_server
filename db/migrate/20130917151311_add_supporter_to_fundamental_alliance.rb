class AddSupporterToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :supporter, :boolean
  end
end
