class RemoveMaxLengthFromTrainingQueue < ActiveRecord::Migration
  def change
    remove_column :training_queues, :max_length
  end
end
