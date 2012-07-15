class RenameNumToOriginalIdInFundamentalAnnouncement < ActiveRecord::Migration
  def change
    rename_column :fundamental_announcements, :num, :original_id
  end
end
