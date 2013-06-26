class CreateAssignmentSpecialAssignmentFrequencies < ActiveRecord::Migration
  def change
    create_table :assignment_special_assignment_frequencies do |t|
      t.integer :character_id
      t.integer :type_id
      t.integer :num_failed
      t.datetime :last_ended_at
      t.integer :execution_count, :default => 0, :null => false
      t.integer :halved_count, :default => 0, :null => false

      t.timestamps
    end
  end
end
