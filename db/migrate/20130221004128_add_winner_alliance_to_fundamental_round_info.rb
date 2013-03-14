class AddWinnerAllianceToFundamentalRoundInfo < ActiveRecord::Migration
  def change
    add_column :fundamental_round_infos, :winner_alliance_id, :integer
  end
end
