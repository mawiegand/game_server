class AddLastRetentionMailToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :last_retention_mail_id, :integer
    add_column :fundamental_characters, :last_retention_mail_sent_at, :datetime
  end
end
