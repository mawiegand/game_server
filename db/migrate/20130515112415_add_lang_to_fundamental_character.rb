class AddLangToFundamentalCharacter < ActiveRecord::Migration
  def up
    add_column :fundamental_characters, :lang, :string, :default => "en", :null => false
    
    Fundamental::Character.all.each do |character|
      character.lang = "de"
      character.save
    end
  end
  
  def down
    remove_column :fundamental_characters, :lang
  end    
end
