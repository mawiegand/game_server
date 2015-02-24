class InitRetentionBonusToFundamentalCharacter < ActiveRecord::Migration
  def up
    Fundamental::Character.all.each do |character|
      character.init_retention_bonus
      character.save
    end
  end

  def down
    Fundamental::Character.all.each do |character|
      character.can_redeem_retention_bonus_start_time = nil
      character.can_redeem_retention_bonus_at = nil
      character.save
    end
  end
end
