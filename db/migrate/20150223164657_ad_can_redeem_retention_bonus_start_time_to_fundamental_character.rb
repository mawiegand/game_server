class AdCanRedeemRetentionBonusStartTimeToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :can_redeem_retention_bonus_start_time, :datetime
  end
end
