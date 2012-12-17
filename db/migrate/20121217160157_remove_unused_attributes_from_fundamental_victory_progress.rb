class RemoveUnusedAttributesFromFundamentalVictoryProgress < ActiveRecord::Migration
  def change
    remove_column :fundamental_victory_progresses, :percentage
    remove_column :fundamental_victory_progresses, :days
  end
end
