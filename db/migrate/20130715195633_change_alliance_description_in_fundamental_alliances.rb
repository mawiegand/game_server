class ChangeAllianceDescriptionInFundamentalAlliances < ActiveRecord::Migration
  def change
		change_column :fundamental_alliances, :description, :text
  end
end
