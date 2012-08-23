class CreateFundamentalSettings < ActiveRecord::Migration
  def up
    create_table :fundamental_settings do |t|
      t.boolean :email_messages, :default => true, :null => false
      t.integer :character_id
      t.timestamps
    end
    
    Fundamental::Character.all.each do |character|
      character.create_settings     unless character.npc?
    end
    
  end
  
  def down
    drop_table :fundamental_settings
  end
end
