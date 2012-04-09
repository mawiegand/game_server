class CreateFundamentalGuilds < ActiveRecord::Migration
  def change
    create_table :fundamental_guilds do |t|
      t.string :name
      t.string :abbrev
      t.string :description
      t.string :logo
      t.integer :leader_id
      t.boolean :invitation_only
      t.boolean :visible
      t.boolean :membership_public

      t.timestamps
    end
  end
end
