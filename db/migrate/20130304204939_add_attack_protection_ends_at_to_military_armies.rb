class AddAttackProtectionEndsAtToMilitaryArmies < ActiveRecord::Migration
  def change
    add_column :military_armies, :attack_protection_ends_at, :datetime
  end
end
