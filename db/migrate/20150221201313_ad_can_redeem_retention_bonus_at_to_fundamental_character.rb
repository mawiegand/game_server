class AdCanRedeemRetentionBonusAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :can_redeem_retention_bonus_at, :datetime
  end
end
