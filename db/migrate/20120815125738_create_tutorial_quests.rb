class CreateTutorialQuests < ActiveRecord::Migration
  def change
    create_table :tutorial_quests do |t|
      t.integer :state_id
      t.integer :quest_id
      t.boolean :finished
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
