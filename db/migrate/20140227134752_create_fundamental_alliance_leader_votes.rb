class CreateFundamentalAllianceLeaderVotes < ActiveRecord::Migration
  def self.up
    create_table :fundamental_alliance_leader_votes do |t|
      t.integer :alliance_id
      t.integer :voter_id
      t.integer :candidate_id

      t.timestamps
    end
    Fundamental::Character.where("alliance_id IS NOT NULL").each do |char|
      Fundamental::AllianceLeaderVote.create(alliance: char.alliance, voter: char, candidate: char.alliance.leader)
    end
  end
  
  def self.down
    drop_table :fundamental_alliance_leader_votes
  end
end
