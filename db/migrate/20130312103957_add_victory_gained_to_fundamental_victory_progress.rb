class AddVictoryGainedToFundamentalVictoryProgress < ActiveRecord::Migration
  def change
    add_column :fundamental_victory_progresses, :victory_gained, :boolean
  end
end
