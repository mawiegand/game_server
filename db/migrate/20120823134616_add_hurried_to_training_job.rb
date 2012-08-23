class AddHurriedToTrainingJob < ActiveRecord::Migration
  def change
    add_column :training_jobs, :hurried, :boolean, :default => false, :null => false
  end
end
