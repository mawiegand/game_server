class CreateFundamentalAllianceReservations < ActiveRecord::Migration
  def change
    create_table :fundamental_alliance_reservations do |t|
      t.integer :alliance_id
      t.string :tag
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
