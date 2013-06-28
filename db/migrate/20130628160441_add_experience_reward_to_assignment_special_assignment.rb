class AddExperienceRewardToAssignmentSpecialAssignment < ActiveRecord::Migration
  def change
    add_column :assignment_special_assignments, :experience_reward, :integer
  end
end
