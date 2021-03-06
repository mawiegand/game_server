class Military::BattleParticipantResult < ActiveRecord::Base
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :participant_results
  belongs_to :round, :class_name => "Military::BattleRound", :foreign_key => "round_id", :inverse_of => :faction_results
  belongs_to :faction_result, :class_name => "Military::BattleFactionResult", :foreign_key => "battle_faction_result_id", :inverse_of => :participant_results
  belongs_to :army,    :class_name => "Military::Army",          :foreign_key => "army_id"#,    :inverse_of => :battle_participant_results
  belongs_to :participant,    :class_name => "Military::BattleParticipant",          :foreign_key => "participant_id",    :inverse_of => :results

  def get_unit_reduce_hash
  	result = Hash.new
  	rules = GameRules::Rules.the_rules
  	rules.unit_types.each do |t|
  		result[t[:db_field]] = self[t[:db_field].to_s+"_casualties"]
  		result[t[:db_field]] = 0 if result[t[:db_field]] == nil
  	end
  	result
  end

  def get_units_of_unit_type(unit_type)
    result = self[unit_type[:db_field].to_s]
    result = 0 if result == nil
    result
  end

  def get_unit_casualties_of_unit_type(unit_type)
    result = self[unit_type[:db_field].to_s+"_casualties"]
    result = 0 if result == nil
    result
  end

  def get_unit_damage_inflicted_of_unit_type(unit_type)
    result = self[unit_type[:db_field].to_s+"_damage_inflicted"]
    result = 0 if result == nil
    result
  end

  def units_count
    count = 0
  	GameRules::Rules.the_rules.unit_types.each do |unit_type|
  		count += (self[unit_type[:db_field].to_s] || 0)
  	end
  	count
  end
  
  def lost_units_count
    count = 0
  	GameRules::Rules.the_rules.unit_types.each do |unit_type|
  		count += (self[unit_type[:db_field].to_s+"_casualties"] || 0)
  	end
  	count
  end

  def xp_weighted_units_count
    count = 0
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      count += (self[unit_type[:db_field].to_s] || 0) * (unit_type[:experience_factor] || 1.0)
    end
    count
  end

  def xp_weighted_lost_units_count
    count = 0
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      count += (self[unit_type[:db_field].to_s+"_casualties"] || 0) * (unit_type[:experience_factor] || 1.0)
    end
    count
  end
end
