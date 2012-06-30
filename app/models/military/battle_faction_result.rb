class Military::BattleFactionResult < ActiveRecord::Base
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :faction_results
  belongs_to :round, :class_name => "Military::BattleRound", :foreign_key => "round_id", :inverse_of => :faction_results
  belongs_to :faction, :class_name => "Military::BattleFaction", :foreign_key => "faction_id", :inverse_of => :faction_results

  has_many   :participant_results, :class_name => "Military::BattleParticipantResult", :foreign_key => "battle_faction_result_id", :inverse_of => :faction_result


  def calculate_total_stats
  	rules = GameRules::Rules.the_rules

  	result = Hash.new
  	result[:casualties] = 0
  	result[:kills] = 0
  	result[:damage_taken] = 0.0
  	result[:damage_inflicted] = 0.0
  	result[:experience_gained] = 0.0
  	participant_results.each do |participant_result|
  		rules.unit_types.each do |t|
  			#casualties
  			casualties = participant_result[t[:db_field].to_s+"_casualties"]
  			result[:casualties] += casualties if casualties != nil
  			#damage_taken
  			damage_taken = participant_result[t[:db_field].to_s+"_damage_taken"]
  			result[:damage_taken] += damage_taken if damage_taken != nil
  			#damage_inflicted
  			damage_inflicted = participant_result[t[:db_field].to_s+"_damage_inflicted"] 
  			result[:damage_inflicted] += damage_inflicted if damage_inflicted != nil
    	end
  		#kills
  		result[:kills] += participant_result.kills
  		#experience
  		result[:experience_gained] += participant_result.experience_gained
  	end
  	result
  end
end
