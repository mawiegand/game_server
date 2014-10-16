class CreateGoogleAppConfigs < ActiveRecord::Migration
  def change
    create_table :google_app_configs do |t|
      t.string :client_id
      t.string :client_secret
      t.string :code
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
