class CreateAssignmentSpecialAssignments < ActiveRecord::Migration
  def change
    create_table :assignment_special_assignments do |t|
      t.integer :character_id
      t.integer :type_id
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :halved_at
      t.integer :execution_count, :default => 0, :null => false
      t.datetime :displayed_until
      t.datetime :seen_at

      t.timestamps
    end
  end
end
