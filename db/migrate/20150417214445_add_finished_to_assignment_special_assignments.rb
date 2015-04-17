class AddFinishedToAssignmentSpecialAssignments < ActiveRecord::Migration
  def change
    add_column :assignment_special_assignments, :finished, :boolean, :default => false
  end
end
