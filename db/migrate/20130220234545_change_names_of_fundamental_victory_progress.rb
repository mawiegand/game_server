class ChangeNamesOfFundamentalVictoryProgress < ActiveRecord::Migration
  def change
    rename_column :fundamental_victory_progresses, :victory_type, :type_id
  end
end
