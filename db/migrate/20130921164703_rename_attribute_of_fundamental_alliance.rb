class RenameAttributeOfFundamentalAlliance < ActiveRecord::Migration
  def change
    rename_column :fundamental_alliances, :supporter, :divine_supporter
  end
end
