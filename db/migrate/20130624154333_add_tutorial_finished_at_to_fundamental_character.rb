class AddTutorialFinishedAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :tutorial_finished_at, :datetime
  end
end
