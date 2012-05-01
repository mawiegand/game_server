class CreateBackendUsers < ActiveRecord::Migration
  def change
    create_table :backend_users do |t|
      t.string :email
      t.string :salt
      t.string :encrypted_password
      t.boolean :admin
      t.boolean :staff
      t.string :firstname
      t.string :surname
      t.string :login
      t.boolean :deleted

      t.timestamps
    end
  end
end
