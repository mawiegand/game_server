class RemoveSupporterToFundamentalAlliance < ActiveRecord::Migration
  def change
    remove_column :fundamental_alliances, :supporter
  end
end
