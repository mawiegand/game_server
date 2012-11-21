class CreateFundamentalRetentionMails < ActiveRecord::Migration
  def change
    create_table :fundamental_retention_mails do |t|
      t.integer :character_id
      t.integer :credit_reward
      t.string :mail_type
      t.string :identifier
      t.datetime :redeemed_at

      t.timestamps
    end
  end
end
