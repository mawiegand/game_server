class CreateBackendSignInLogEntries < ActiveRecord::Migration
  def change
    create_table :backend_sign_in_log_entries do |t|
      t.integer :character_id
      t.text :user_agent
      t.string :referer
      t.text :referer_url
      t.string :remote_ip

      t.timestamps
    end
  end
end
