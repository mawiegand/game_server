class AddMessageIdToMilitaryBattle < ActiveRecord::Migration
  def change
    add_column :military_battles, :message_id, :integer
  end
end
