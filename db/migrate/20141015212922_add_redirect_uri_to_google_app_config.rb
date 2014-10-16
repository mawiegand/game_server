class AddRedirectUriToGoogleAppConfig < ActiveRecord::Migration
  def change
    add_column :google_app_configs, :redirect_uri, :string
  end
end
