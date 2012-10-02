class DeleteMaxLengthFromConstructionQueue < ActiveRecord::Migration
  def change
    remove_column :construction_queues, :max_length
  end

end
