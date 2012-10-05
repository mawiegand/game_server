class CreateBackendBrowserStats < ActiveRecord::Migration
  def change
    create_table :backend_browser_stats do |t|
      t.string :identifier
      t.boolean :success
      t.string :user_agent
      t.text :modernizr

      t.timestamps
    end
  end
end
