class AddAssignmentLevelToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :assignment_level, :integer, :default => 0, :null => false
  end
end
