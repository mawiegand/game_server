class CreateLikeSystemLikes < ActiveRecord::Migration
  def change
    create_table :like_system_likes do |t|

      t.timestamps
    end
  end
end
