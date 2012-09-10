class AddPublicToFundamentalAnnouncement < ActiveRecord::Migration
  def change
    add_column :fundamental_announcements, :public, :boolean, :default => true, :null => false
  end
end
