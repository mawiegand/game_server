class AddFirstFulfilledAtToFundamentalVictoryProgress < ActiveRecord::Migration
  def change
    add_column :fundamental_victory_progresses, :first_fulfilled_at, :datetime
  end
end
