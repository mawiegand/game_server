class AddFinishedToAssignmentStandardAssignments < ActiveRecord::Migration
  def change
    add_column :assignment_standard_assignments, :finished, :boolean, :default => false
  end
end
