class CreateTutorialStates < ActiveRecord::Migration
  def change
    create_table :tutorial_states do |t|
      t.integer :character_id

      t.timestamps
    end
  end
end
