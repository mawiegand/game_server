class CreateFacebookAppConfigs < ActiveRecord::Migration
  def change
    create_table :facebook_app_configs do |t|
      t.string :app_id
      t.string :app_secret
      t.string :app_token

      t.timestamps
    end
  end
end
