class Fundamental::RoundInfo < ActiveRecord::Base
  
  def self.the_round_info
    Fundamental::RoundInfo.find(1)  
  end
  
end
