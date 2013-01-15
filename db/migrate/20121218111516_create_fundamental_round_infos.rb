class CreateFundamentalRoundInfos < ActiveRecord::Migration
  def up
    create_table :fundamental_round_infos do |t|
      t.string :name
      t.datetime :started_at
      t.integer :regions_count, :default => 0, :null => false

      t.timestamps
    end
    
    Fundamental::RoundInfo.create({
      name: "Rundenname",
      started_at: Time.now,
    })
  end
  
  def down
    drop_table :fundamental_round_infos
  end
end
