class Ticker::BattleHandler::UnitSummary
	#unit_stats is a Hash with symbolic_id of unit_type as key and a hash with the stats as value.
	# the subhash currently containes the values: 
	# :unit_type => unit_type 
	# :num => num units at start
	# :casualties => sum of casualties of this unit type
	# :damage_inflicted => sum of the damage that was inflicted by this unit type
	attr_accessor :unit_stats, :sum_units, :sum_casulties, :sum_damage_inflicted, :sum_experience_gained

	def initialize
		@unit_stats = Hash.new
		@sum_units = 0
		@sum_casulties = 0
		@sum_damage_inflicted = 0
		@sum_experience_gained = 0
	end

	def update_with_participant(participant)
		army = participant.army
		if !army.nil?
			rules = GameRules::Rules.the_rules
			rules.unit_types.each do |unit_type|
				num = army.number_of_units_of_type(unit_type)
				if (num > 0)
					if (@unit_stats[unit_type[:symbolic_id]].nil?)
					@unit_stats[unit_type[:symbolic_id]] = { 
						:unit_type => unit_type,
						:num => 0, 
						:casualties => 0, 
						:damage_inflicted => 0}
					end
					stat = @unit_stats[unit_type[:symbolic_id]] 
					stat[:num] += num
					@sum_units += num
				end
			end
		end
	end

	def update_based_on_result(new_participant, participant_result)
		rules = GameRules::Rules.the_rules
		#puts rules.unit_types
		rules.unit_types.each do |unit_type|
			num = participant_result.get_units_of_unit_type(unit_type)
			if (num > 0)
				#init
				if (@unit_stats[unit_type[:symbolic_id]].nil?)
					@unit_stats[unit_type[:symbolic_id]] = { 
						:unit_type => unit_type,
						:num => 0, 
						:casualties => 0, 
						:damage_inflicted => 0}
				end
				stat = @unit_stats[unit_type[:symbolic_id]] 
				#num
				if (new_participant)
					stat[:num] += num
					@sum_units += num
				end
				#casualties
				casualties = participant_result.get_unit_casualties_of_unit_type(unit_type)
				stat[:casualties] += casualties
				@sum_casulties += casualties
				#damage_inflicted
				damage_inflicted = participant_result.get_unit_damage_inflicted_of_unit_type(unit_type)
				stat[:damage_inflicted] += damage_inflicted
				@sum_damage_inflicted += damage_inflicted
			end
		end
		#experience_gained
		@sum_experience_gained += participant_result.experience_gained
	end

	def get_damage_percentage(max_damage)
		return 0 unless (@sum_damage_inflicted > 0)
		(@sum_damage_inflicted.to_f / max_damage.to_f * 100.0)
	end

	def get_num_percentage(max_num)
		return 0 unless (@sum_units > 0)
		(@sum_units.to_f / max_num.to_f * 100.0)
	end

	def get_casulties_percentage(max_value)
		return 0 unless (@sum_casulties > 0)
		(@sum_casulties.to_f / max_value.to_f * 100.0)
	end

	def get_survivor_percentage(max_value)
		survivors = @sum_units - @sum_casulties
		return 0 unless (survivors > 0)
		(survivors.to_f / max_value.to_f * 100.0)
	end
end