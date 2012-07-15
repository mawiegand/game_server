class CreateFundamentalAnnouncements < ActiveRecord::Migration
  def change
    create_table :fundamental_announcements do |t|
      t.integer :num
      t.string :locale
      t.string :heading
      t.text :body
      t.datetime :expires
      t.integer :user_id

      t.timestamps
    end
  end
end
