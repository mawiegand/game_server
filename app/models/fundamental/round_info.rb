class Fundamental::RoundInfo < ActiveRecord::Base
  
  def self.the_round_info
    Fundamental::RoundInfo.find(1)  
  end
  
  def victory_gained?
    !self.victory_gained_at.nil?
  end
  
  # return age of round in full days (integer)
  def age
    ((Time.now - self.started_at)/(3600*24)).to_i
  end
end
