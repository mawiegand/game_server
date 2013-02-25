class Fundamental::RoundInfo < ActiveRecord::Base

  belongs_to  :winner_alliance, :class_name => 'Fundamental::Alliance', :foreign_key => 'winner_alliance_id'

  # TODO after_save handler fuer eingetragenen sieg
  
  def self.the_round_info
    Fundamental::RoundInfo.find(1)  
  end
  
  def victory_gained?
    !self.winner_alliance.nil?
  end
  
  # return age of round in full days (integer)
  def age
    ((Time.now - self.started_at)/(3600*24)).to_i
  end
end
