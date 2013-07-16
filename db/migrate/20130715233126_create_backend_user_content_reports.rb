class CreateBackendUserContentReports < ActiveRecord::Migration
  def change
    create_table :backend_user_content_reports do |t|
      t.integer :reporter_id
      t.integer :content_owner_id
      t.string :content_type
      t.integer :content_id
      t.boolean :declined
      t.boolean :accepted

      t.timestamps
    end
  end
end
