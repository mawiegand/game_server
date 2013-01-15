class AddSameIpToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :same_ip, :string
  end
end
