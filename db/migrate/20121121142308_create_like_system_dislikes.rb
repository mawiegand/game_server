class CreateLikeSystemDislikes < ActiveRecord::Migration
  def change
    create_table :like_system_dislikes do |t|

      t.timestamps
    end
  end
end
