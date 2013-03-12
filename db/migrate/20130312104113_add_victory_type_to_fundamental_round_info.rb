class AddVictoryTypeToFundamentalRoundInfo < ActiveRecord::Migration
  def change
    add_column :fundamental_round_infos, :victory_type, :integer
  end
end
