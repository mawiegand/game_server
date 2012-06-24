class Military::BattleParticipantResult < ActiveRecord::Base
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :participant_results
  belongs_to :round, :class_name => "Military::BattleRound", :foreign_key => "round_id", :inverse_of => :faction_results
  belongs_to :faction_result, :class_name => "Military::BattleFactionResult", :foreign_key => "battle_faction_result_id", :inverse_of => :participant_results
  belongs_to :army,    :class_name => "Military::Army",          :foreign_key => "army_id"#,    :inverse_of => :battle_participant_results

  def get_unit_reduce_hash
  	result = Hash.new
  	rules = GameRules::Rules.the_rules
  	rules.unit_types.each do |t|
  		result[t[:db_field]] = self[t[:db_field].to_s+"_casualties"]
  		result[t[:db_field]] = 0 if result[t[:db_field]] == nil
  	end
  	result
  end

end
