class CreateAssignmentStandardAssignments < ActiveRecord::Migration
  def change
    create_table :assignment_standard_assignments do |t|
      t.integer :character_id
      t.integer :type_id
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :halved_at
      t.integer :execution_count, :default => 0, :null => false
      t.integer :halved_count, :default => 0, :null => false

      t.timestamps
    end
  end
end
