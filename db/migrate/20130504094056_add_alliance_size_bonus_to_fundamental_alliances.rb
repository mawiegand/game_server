class AddAllianceSizeBonusToFundamentalAlliances < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :size_bonus, :integer, :default => 0
  end
end
