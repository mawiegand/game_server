class CreateFundamentalGossips < ActiveRecord::Migration
  def change
    create_table :fundamental_gossips do |t|
      t.string :content_type
      t.datetime :ended_at
      t.text :content

      t.timestamps
    end
  end
end
