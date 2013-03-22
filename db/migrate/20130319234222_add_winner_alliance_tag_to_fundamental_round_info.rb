class AddWinnerAllianceTagToFundamentalRoundInfo < ActiveRecord::Migration
  def change
    add_column :fundamental_round_infos, :winner_alliance_tag, :string
  end
end
