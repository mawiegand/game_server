class AddVictoryGainedAtToFundamentalRoundInfo < ActiveRecord::Migration
  def change
    add_column :fundamental_round_infos, :victory_gained_at, :datetime
  end
end
