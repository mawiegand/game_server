class AddNumberToFundamentalRoundInfo < ActiveRecord::Migration
  def change
    add_column :fundamental_round_infos, :number, :integer, :default => 0, :null => false
  end
end
