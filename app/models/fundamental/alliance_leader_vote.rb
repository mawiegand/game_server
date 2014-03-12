class Fundamental::AllianceLeaderVote < ActiveRecord::Base
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :leader_votes
  belongs_to :voter, :class_name => "Fundamental::Character", :foreign_key => "voter_id", :inverse_of => :alliance_leader_vote
  belongs_to :candidate, :class_name => "Fundamental::Character", :foreign_key => "candidate_id", :inverse_of => :alliance_leader_candidate
end
