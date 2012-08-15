class CreateBackendStats < ActiveRecord::Migration
  def change
    create_table :backend_stats do |t|
      t.integer :new_users
      t.integer :dau
      t.integer :wau
      t.integer :mau
      t.integer :active_users
      t.decimal :churn_today
      t.decimal :churn_week
      t.decimal :churn_month
      t.integer :dac
      t.integer :wac
      t.integer :mac
      t.integer :du
      t.integer :wu
      t.integer :mu
      t.integer :dc
      t.integer :wc
      t.integer :mc

      t.timestamps
    end
  end
end
