module Ticker
  module BattleHandlerMessageFactory

  def runloop 
    return @runloop 
  end

  ## fight started message ###############################################
  
  ## army destroyed message ##############################################

  ## retreat message #####################################################
  
  def participants_from_awe_battle(awe_battle, battle)
    #search for all characters
    characters = Hash.new 

    (0..(awe_battle.numFactions-1)).each do | f |

      awe_faction = awe_battle.getFaction(f)
      faction = battle.factions[f]

      (0..(awe_faction.numArmies-1)).each do | a |

        participant = faction.participants[a]
        owner = participant.army.owner
        characters[owner.id] = Array.new if (!characters.has_key?(owner.id))
        characters[owner.id] << participant
      end
    end
    characters
  end
  
  def participants_from_battle(battle)
    #search for all characters
    characters = Hash.new 

    battle.factions.each do | faction |
      faction.participants.each do | participant |
        if !participant.disbanded? && !participant.army.nil?
          owner = participant.army.owner
          characters[owner.id] = Array.new if (!characters.has_key?(owner.id))
          characters[owner.id] << participant   # store all participating armies for each participating character id
        end
      end
    end
    characters
  end  

  ## battle message ######################################################
  
  def generate_messages_for_battle(awe_battle, battle)

    stats_body = generate_message_stats_body(battle)
    details_body = generate_message_details_body(battle)

    #search for all characters
    characters = awe_battle.nil? ?  participants_from_battle(battle) : participants_from_awe_battle(awe_battle, battle) 

    #generate the messages for the characters
    characters.each do |k,v|
      character = v[0].army.owner
      if !character.npc?                    # no messages for npcs!
        message = Messaging::Message.new


        message.recipient_id = character.id
        message.sender_id = nil
        message.type_id = Messaging::Message::BATTLE_REPORT_TYPE_ID
        message.subject = generate_message_subject(battle)
        message.body = "<h1>"+generate_message_subject(battle)+"</h1>"
        message.body = message.body + stats_body 
        message.body = message.body + generate_message_body_for_character(battle, character, v, stats_body, details_body)
        message.body = message.body + details_body
        message.send_at = DateTime.now
       # message.reported = false
      #  message.flag = 0

        message.save
      
        battle.message = message if battle.message.nil?
      end
    end
    
    if battle.message.nil? # e.g. no remaining characters in fight. this really may happen! (retreats, disbanded and dissolved troops)
      message = Messaging::Message.create({
        type_id:  Messaging::Message::BATTLE_REPORT_TYPE_ID,
        subject:  generate_message_subject(battle),
        body:     "<h1>"+generate_message_subject(battle)+"</h1>" + stats_body + details_body,
        send_at:  DateTime.now,
      })                   # will be delivered to noone, used to display a report in the back-end
      battle.message = message    
    end    
  end

  def generate_message_body_for_character(battle, character, participants, stats_body, details_body)
    result = "<h2>Your participating armies</h2>\n"
    participants.each do |v|
      puts v
      result = result + generate_participant_body(battle, v)
    end
    result
  end

  def generate_message_subject(battle)
    return "The battle at " + (battle.location.settlement.nil? ? (battle.region.name || "Waste").to_s : battle.location.settlement.name.to_s);
  end

  def generate_participant_body(battle, participant)
    result = ""
    result = participant.army.name.to_s + " " unless participant.army.name.nil?
    result = result + "of " + participant.army.home_settlement_name + " " unless participant.army.home_settlement_name.nil?
    if (participant.army.has_units?)
      if (participant.retreated)
        result = result + "RETREATED"
      else
        result = result + "<font color='green'>SURVIVED</font>"
      end
    else
      result = result + "<font color='red'>DESTROYED</font>"
    end
    result = result + "<br>\n<br>\n"

    #army details
    total_results = Hash.new
    unit_types_results = Hash.new
    total_results[:casualties] = 0
    total_results[:kills] = 0
    total_results[:damage_inflicted] = 0
    total_results[:damage_taken] = 0
    total_results[:experience_gained] = participant.total_experience_gained

    rules = GameRules::Rules.the_rules
    rules.unit_types.each do |t|
      unit_types_results[t[:db_field]] = { 
        :start => 0, 
        :casualties => 0,
        :damage_inflicted => 0
      }
    end

    start = true

    #callculate the total & unit type detail results
    battle.rounds.order("round_num ASC").each do |round|
      #get the participant result for this round
      participant_result = round.participant_results.where("army_id = ?", participant.army_id)
      if participant_result.length == 1
        participant_result = participant_result[0]
        if participant_result != nil
          #go through all the fields for the unit types
          rules.unit_types.each do |t|
            #read out start unit count
            if start
              unit_types_results[t[:db_field]][:start] = participant_result[t[:db_field]];
            end
            #read out the casualties
            casualties = participant_result[t[:db_field].to_s + "_casualties"]
            if !casualties.nil?
            	unit_types_results[t[:db_field]][:casualties] += casualties
            	total_results[:casualties] += casualties
        	end

            #read out the damage_taken
            damage_taken = participant_result[t[:db_field].to_s + "_damage_taken"]
            total_results[:damage_taken] += damage_taken unless damage_taken.nil?

            #read out the damage_inflicted
            damage_inflicted = participant_result[t[:db_field].to_s + "_damage_inflicted"]
            if !damage_inflicted.nil?
            	total_results[:damage_inflicted] += damage_inflicted
            	unit_types_results[t[:db_field]][:damage_inflicted] += damage_inflicted
        	end
          end
          start = false

          #kills
          total_results[:kills] += participant_result.kills
        end
      else # participant_result.length > 1
        runloop.say("found more than one military_participant_result for army_id="+participant.army_id.to_s+" and round_id= "+round.id.to_s)#, Logger::WARN)
      end
    end

    #generate the html
    #unit type stats
    result += "<table>"
    result += "<tr>\n"
    result += "<td></td>\n";
    rules.unit_types.each do |t|
      result += "<td><b>"+get_unit_type_name(t)+"</b></td>\n";
    end
    result += "</tr>\n";
    #start units
    result += "<tr>\n"
    result += "<td>Units</td>\n";
    rules.unit_types.each do |t|
      result += "<td>"+unit_types_results[t[:db_field]][:start].to_s+"</td>\n"
    end
    #casualties
    result += "<tr>\n"
    result += "<td>Casualties</td>\n";
    rules.unit_types.each do |t|
      result += "<td>"+unit_types_results[t[:db_field]][:casualties].to_s+"</td>\n"
    end
    result += "</tr>\n";
    #survivor
    result += "<tr>\n"
    result += "<td>Survivors</td>\n";
    rules.unit_types.each do |t|
      result += "<td>"+((unit_types_results[t[:db_field]][:start] || 0) - (unit_types_results[t[:db_field]][:casualties] || 0)).to_s+"</td>\n"
    end
    result += "</tr>\n";
    #damage_inflicted
    result += "<tr>\n"
    result += "<td>Damage Inflicted</td>\n";
    rules.unit_types.each do |t|
      result += "<td>"+unit_types_results[t[:db_field]][:damage_inflicted].round(0).to_s+"</td>\n"
    end
    result += "</tr>\n";
    #end unit type stats
    result += "</table>\n"
    result += "<br><br>\n"
    #total stats
    result += "<table>\n"
    #casualties
    result += "<tr>\n"
    result += "<td>Total Casualties</td>\n";
    result += "<td>"+total_results[:casualties].to_s+"</td>\n"
    result += "</tr>\n"
    #kills
    result += "<tr>\n"
    result += "<td>Total Kills</td>\n";
    result += "<td>"+total_results[:kills].to_s+"</td>\n"
    result += "</tr>\n"
    #damage inflicted
    result += "<tr>\n"
    result += "<td>Damage Inflicted</td>\n";
    result += "<td>"+total_results[:damage_inflicted].round(0).to_s+"</td>\n"
    result += "</tr>\n"
    #damage taken
    result += "<tr>\n"
    result += "<td>Damage Taken</td>\n";
    result += "<td>"+total_results[:damage_taken].round(0).to_s+"</td>\n"
    result += "</tr>\n"
    #experience
    result += "<tr>\n"
    result += "<td>Experience</td>\n";
    result += "<td>+"+total_results[:experience_gained].to_s+"</td>\n"
    result += "</tr>\n"
    result += "</table>\n"
    #end total stats
    result
  end

  def generate_message_details_body(battle)
    result = "<h2>Details</h2>\n"
    
    rules = GameRules::Rules.the_rules

    #for all rounds
    battle.rounds.each do |round|

      if round.round_num == 0
        result += "<h3>Initiation</h3>\n"
        result += write_out_inital_details(battle, round)
      end

      result += "<h3>Round "+(round.round_num+1).to_s+"</h3>\n"

      #for each faction result
      initiator_result = ""
      opponent_result = ""
      unknown_result = ""

      round.faction_results.each do |faction_result|
        current_result = ""

        #Faction name
        if battle.initiator_id == faction_result.leader_id
          current_result += "<h4>Faction A</h4>"
        elsif battle.opponent_id == faction_result.leader_id
          current_result += "<h4>Faction B</h4>"
        else
          current_result += "<h4>Unknown Faction</h4>"
          runloop.say("got more than two factions", Logger::WARN)
        end

        #generate table for all armies
        current_result += "<table>\n"
        current_result += "<tr>\n"
        current_result += "<td></td>\n" #army.name
        current_result += "<td></td>\n" #character.name
        current_result += "<td></td>\n" #character.alliance_tag
        rules.unit_types.each do |t|
          current_result += "<td>"+get_unit_type_name(t)+"</td>\n"
        end
        current_result += "</tr>\n"

        #for all participant_results
        faction_result.participant_results.each do |participant_result|
          current_result += "<tr>\n"
          current_result += "<td>"+(participant_result.army.blank? ? "Missing Army": participant_result.army.name)+"</td>\n" #army.name
          current_result += "<td>"+(participant_result.army.blank? || participant_result.army.owner.blank? ? "" : participant_result.army.owner.name)+"</td>\n" #character.name
          if participant_result.army.nil? || participant_result.army.alliance.nil?
            current_result += "<td></td>\n" #character.alliance_tag
          else
            current_result += "<td>"+participant_result.army.alliance.tag+"</td>\n" #character.alliance_tag
          end
          rules.unit_types.each do |t|
            current_result += "<td>"+participant_result[t[:db_field]].to_s
            #if round.round_num > 0
              current_result += " (-"+participant_result[t[:db_field].to_s+"_casualties"].to_s+")"
            #end
            current_result += "</td>\n"
          end
          current_result += "</tr>\n"
        end
        current_result += "</table>\n"
        current_result += "<br><br>\n"

        #write out the total result
        current_result += generate_total_table(faction_result.calculate_total_stats)
        current_result += "<br><br>\n"

        #write into the apropriate output to ensure correct order
        if battle.initiator_id == faction_result.leader_id
          initiator_result += current_result
        elsif battle.opponent_id == faction_result.leader_id
          opponent_result += current_result
        else
          unknown_result += current_result
        end
      end

      result += initiator_result
      result += opponent_result
      result += unknown_result

    end
    result
  end

  def write_out_inital_details(battle, round)
	  result = ""
	  rules = GameRules::Rules.the_rules

	  #for each faction result
	  initiator_result = ""
	  opponent_result = ""
	  unknown_result = ""

	  round.faction_results.each do |faction_result|
	    current_result = ""

	    #Faction name
	    if battle.initiator_id == faction_result.leader_id
	      current_result += "<h4>Faction A</h4>"
	    elsif battle.opponent_id == faction_result.leader_id
	      current_result += "<h4>Faction B</h4>"
	    else
	      current_result += "<h4>Unknown Faction</h4>"
	      runloop.say("got more than two factions", Logger::WARN)
	    end

	    #generate table for all armies
	    current_result += "<table>\n"
	    current_result += "<tr>\n"
	    current_result += "<td></td>\n" #army.name
	    current_result += "<td></td>\n" #character.name
	    current_result += "<td></td>\n" #character.alliance_tag
	    rules.unit_types.each do |t|
	      current_result += "<td>"+get_unit_type_name(t)+"</td>\n"
	    end
	    current_result += "</tr>\n"

	    #for all participant_results
	    faction_result.participant_results.each do |participant_result|
	      current_result += "<tr>\n"
	      current_result += "<td>"+(participant_result.army.blank? ? "Missing Army" : participant_result.army.name)+"</td>\n" #army.name
	      current_result += "<td>"+(participant_result.army.blank? || participant_result.army.owner.blank? ? "" : participant_result.army.owner.name)+"</td>\n" #character.name
        if participant_result.army.nil? || participant_result.army.alliance.nil?
          current_result += "<td></td>\n" #character.alliance_tag
        else
	       current_result += "<td>"+participant_result.army.alliance.tag+"</td>\n" #character.alliance_tag
        end
	      rules.unit_types.each do |t|
	        current_result += "<td>"+participant_result[t[:db_field]].to_s
	        current_result += "</td>\n"
	      end
	      current_result += "</tr>\n"
	    end
	    current_result += "</table>\n"
	    current_result += "<br><br>\n"

	    #write into the apropriate output to ensure correct order
	    if battle.initiator_id == faction_result.leader_id
	      initiator_result += current_result
	    elsif battle.opponent_id == faction_result.leader_id
	      opponent_result += current_result
	    else
	      unknown_result += current_result
	    end
	  end

	  result += initiator_result
	  result += opponent_result
	  result += unknown_result
	  result
  end 

  def generate_total_table(total_hash_map)
    current_result = "<table>\n"
    current_result += "<tr>\n"
    current_result += "<td>Total Casualties</td>\n"
    current_result += "<td>"+total_hash_map[:casualties].to_s+"</td>\n"
    current_result += "</tr>\n"
    current_result += "<tr>\n"
    current_result += "<td>Total Kills</td>\n"
    current_result += "<td>"+total_hash_map[:kills].to_s+"</td>\n"
    current_result += "</tr>\n"
    current_result += "<tr>\n"
    current_result += "<td>Damage Inflicted</td>\n"
    current_result += "<td>"+total_hash_map[:damage_inflicted].round(0).to_s+"</td>\n"
    current_result += "</tr>\n"
    current_result += "<tr>\n"
    current_result += "<td>Damage Taken</td>\n"
    current_result += "<td>"+total_hash_map[:damage_taken].round(0).to_s+"</td>\n"
    current_result += "</tr>\n"
    current_result += "<tr>\n"
    current_result += "<td>Experience</td>\n"
    current_result += "<td>"+total_hash_map[:experience_gained].round(0).to_s+"</td>\n"
    current_result += "</tr>\n"
    current_result += "</table>\n"
  end

  def generate_message_stats_body(battle)
    initiator = battle.initiator
    opponent = battle.opponent
    result = "This conflict was initiated by an attack of "+generate_character_message_str(initiator)+" on "+generate_character_message_str(opponent)+" on "+battle.started_at.to_s+"<br>\n<br>\n"
    
    result = result+"Participants on side of "+generate_character_message_str(initiator)+" (faction A):<br>\n"
    initiator_faction = battle.factions.where("faction_num = 0").first
    initiator_faction.participants.all.each do |p|
      owner = p.disbanded? ? nil : p.army.owner
      result = result + generate_character_message_str(owner) + "<br>\n"
    end
    result = result + "<br>\n"
    
    result = result+"Participants on side of "+generate_character_message_str(opponent)+" (faction B):<br>\n"
    opponent_faction = battle.factions.where("faction_num = 1").first
    opponent_faction.participants.each do |p|
      owner = p.disbanded? ? nil : p.army.owner
      result = result + generate_character_message_str(owner) +"<br>\n"
    end
    result = result + "<br>\n"

    rules = GameRules::Rules.the_rules
    rounds = battle.rounds.order("round_num ASC")
    
    if rounds.length < 1    # may happen in case the home base(s) of all armies of one side are lost before the first round
      result = result + '<p><b>There was no fighting as one faction completely dissolved before the battle could start.</b></p>'
    else 
      result = result + "<h2>Faction A</h2>\n"
      initiator_combined_faction_result = generate_combined_faction_results(initiator_faction, rounds[0])
      #initiator_faction_results = initiator_faction.faction_results
      result = result + generate_faction_units_table(initiator_combined_faction_result)

      result = result + "<h2>Faction B</h2>\n"
      #opponent_faction_results = opponent_faction.faction_results
      opponent_combined_faction_result = generate_combined_faction_results(opponent_faction, rounds[0])
      result = result + generate_faction_units_table(opponent_combined_faction_result)

      #stats
      result = result + generate_stats_table(initiator_combined_faction_result, opponent_combined_faction_result)
    end

    result
  end

  def generate_stats_table(combined_faction_a_result, combined_faction_b_result)
    result = "<table>\n"

    result += "<tr>\n"
    result += "<td></td>\n";
    result += "<td><b>Faction A</b></td>\n";
    result += "<td><b>Faction B</b></td>\n";
    result += "</tr>\n";

    result = result + "<tr>\n"
    result = result + "<td>Total Casualties</td>\n";
    result = result + "<td>"+combined_faction_a_result[:casualties].to_s+"</td>\n";
    result = result + "<td>"+combined_faction_b_result[:casualties].to_s+"</td>\n";
    result = result + "</tr>\n";

    result = result + "<tr>\n"
    result = result + "<td>Total Kills</td>\n";
    result = result + "<td>"+combined_faction_a_result[:kills].to_s+"</td>\n";
    result = result + "<td>"+combined_faction_b_result[:kills].to_s+"</td>\n";
    result = result + "</tr>\n";

    result = result + "<tr>\n"
    result = result + "<td>Total Damage Inflicted</td>\n";
    result = result + "<td>"+combined_faction_a_result[:damage_inflicted].round.to_s+"</td>\n";
    result = result + "<td>"+combined_faction_b_result[:damage_inflicted].round.to_s+"</td>\n";
    result = result + "</tr>\n";

    result = result + "<tr>\n"
    result = result + "<td>Total Damage Taken</td>\n";
    result = result + "<td>"+combined_faction_a_result[:damage_taken].round.to_s+"</td>\n";
    result = result + "<td>"+combined_faction_b_result[:damage_taken].round.to_s+"</td>\n";
    result = result + "</tr>\n";

    result = result + "<tr>\n"
    result = result + "<td>Total Experience</td>\n";
    result = result + "<td>"+combined_faction_a_result[:experience_gained].to_s+"</td>\n";
    result = result + "<td>"+combined_faction_b_result[:experience_gained].to_s+"</td>\n";
    result = result + "</tr>\n";

    result = result + "</table>\n<br>\n<br>\n"
    result
  end

  def generate_faction_units_table(combined_faction_result)

    #get the rules
    rules = GameRules::Rules.the_rules
    result = "<table>\n<tr>\n<td></td>\n"
    rules.unit_types.each do |t|
      result = result + "<td>"+get_unit_type_name(t)+"</td>\n";
    end
    result = result + "</tr>\n"

    result = result + "<tr><td>Survivors</td>\n"
    rules.unit_types.each do |t|
      result = result + "<td>"+combined_faction_result[:unit_types][t[:db_field]][:remaining].to_s+"</td>\n";
    end
    result = result + "</tr>\n"

    result = result + "<tr><td>Casualties</td>\n"
    rules.unit_types.each do |t|
      result = result + "<td>"+combined_faction_result[:unit_types][t[:db_field]][:casualties].to_s+"</td>\n";
    end
    result = result + "</tr>\n"

    result = result + "</table>\n<br>\n<br>\n"
    result
  end

  def generate_combined_faction_results(faction, first_round)
    results = Hash.new
    unit_types_results = Hash.new
    results[:unit_types] = unit_types_results
    results[:casualties] = faction.total_casualties
    results[:kills] = faction.total_kills
    results[:damage_inflicted] = faction.total_damage_inflicted
    results[:damage_taken] = faction.total_damage_taken
    results[:experience_gained] = 0

    rules = GameRules::Rules.the_rules
    rules.unit_types.each do |t|
      unit_types_results[t[:db_field]] = { 
        :start => 0, 
        :casualties => 0, 
        :remaining => 0,
      }
    end

    # write in the initial units
    faction_result_round_zero = faction.faction_results.where("round_id = ?", first_round.id).first
    faction_result_round_zero.participant_results.each do |p|
      rules.unit_types.each do |t|
        unit_types_results[t[:db_field]][:start] = unit_types_results[t[:db_field]][:start] + (p[t[:db_field]] || 0)
        unit_types_results[t[:db_field]][:remaining] = unit_types_results[t[:db_field]][:remaining] + (p[t[:db_field]] || 0)
      end
    end

    #remove the lost units
    faction.faction_results.each do |f|
      f.participant_results.each do |p|
        rules.unit_types.each do |t|
          #casualties
          fieldname_casualties = t[:db_field].to_s + "_casualties"
          value_casualties = p[fieldname_casualties]
          if (value_casualties.kind_of?(Integer))
            unit_types_results[t[:db_field]][:remaining] = unit_types_results[t[:db_field]][:remaining] - value_casualties
            unit_types_results[t[:db_field]][:casualties] = unit_types_results[t[:db_field]][:casualties] + value_casualties
          else
            runloop.say("could not read field "+fieldname_casualties.to_s, Logger::WARN)
          end
        end
        #exp
        puts p.experience_gained
        results[:experience_gained] = results[:experience_gained] + p.experience_gained
      end
    end

    results
  end

  def get_unit_type_name(type)
    type[:name][:en_US]
  end

  def generate_dissolved_army_message_str
    #TODO : localize!
    '<span class="red-color" title="An army is dissolved immediately in case its home settlement is lost to another player or destroyed.">Dissolved Force<span>'    
  end

  def generate_character_message_str(character)
    return generate_dissolved_army_message_str if character.nil?
    result = character.name
    unless character.alliance.nil?
      result = result + " | " + character.alliance.tag
    end
    result
  end

end
end