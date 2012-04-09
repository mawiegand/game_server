class CreateFundamentalAlliances < ActiveRecord::Migration
  def change
    create_table :fundamental_alliances do |t|
      t.string :tag
      t.string :name
      t.string :description
      t.string :banner
      t.integer :leader_id
      t.string :password

      t.timestamps
    end
  end
end
