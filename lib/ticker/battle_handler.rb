require 'awe_native_extensions'
require 'ticker/battle_handler_awe_factory'
require 'ticker/battle_handler_result_extractor'
require 'ticker/battle_handler/battle_summary'

class Ticker::BattleHandler
  
  include Ticker::BattleHandlerResultExtractor
  include Ticker::BattleHandlerAweFactory
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "military_battle"
  end
  
  def process_event(event)
    rules = GameRules::Rules.the_rules
    battle = Military::Battle.find(event.local_event_id)
    if battle.nil?
      #runloop.say "Could not find battle for id #{ event.local_event_id }.", Logger::ERROR
    else
      #switch off the garbage collection, to prevent the garbage collector marking not initialized SWIG obects
      gcstate = GC.disable

      #runloop.say "Process battle round #{ battle.battle_rounds_count || 0} for battle #{ battle.id } at loc #{ battle.location_id} in reg #{ battle.region_id }."
    
      if !battle.battle_done?
        ## create and fill the AWE battle
        awe_battle = Battle::Battle.new
        raise InternalServerError.new('Could not create an instance of Battle::Battle (awe_native_extension).') if awe_battle.nil?
      
        runloop.say "started filling awe_battle object"
        fill_awe_battle(battle, awe_battle)
        raise InternalServerError.new('BattleHandler failed to instantiate the battle from the persistent storage.') unless awe_battle.isValid 

        ## create the battle calculator object
        awe_battle_calculator = Battle::BattleCalculator.new
        raise InternalServerError.new('Could not create an instance of Battle::BattleCalculator (awe_native_extension).') if awe_battle_calculator.nil?

        ## calculate one battle round
        runloop.say "calculating this round"
        awe_battle_calculator.callculateOneTick(awe_battle)  # execute round
      
        ## extract and store results in database & handle retreat      
        runloop.say "started extracting results from awe_battle object"
        extract_results_from_awe_battle(awe_battle, battle)

        runloop.say "finished extracting results from awe_battle object"      
      end

      ## check if the battle is over
      if battle.battle_done?

        runloop.say "Mark battle as done."

        battle.ended_at = Time.now
        battle.save

        runloop.say "Determine winner and check takeover"

        ## get winner of the battle
        winner_faction = battle.winner_faction

        #if there is a winner
        if !winner_faction.nil?

          winner_faction.set_winner
          winner_faction.update_leader
          winner_leader = winner_faction.leader

          raise InternalServerError.new('A faction won a battle but did not have a leader') if winner_leader.nil?

          #CALL: take-over-handler
          #        - decides, whether a takeover should happen (settlemenet involved & lost , winners still have a survivor)
          #        - decides, WHO should obtain the settlement (initiator; attacked first, otherwise the strongest winner)
          #        CALL: settlement.new_owner_transaction(character) with character of new owner

          #check if there was a battle over a settlement
          target_settlement = battle.targeted_settlement
          
          takeover = true

          if !target_settlement.nil? && target_settlement.can_be_taken_over?
            #check if the battle location is owned by a participant of the winner faction
            winner_faction.participants.each do |participant|
              if !participant.army.nil? && participant.army.owner_id == battle.location.owner_id   # TODO : danger, danger! if the garrison somehow is killed, an army fighting ON THE SIDE of the garrison would takeover the fortress in case of a victory!
                                                                                                   # -> NEED to store the attacked fortress with the battle when starting a fight!
                                                                                                   # or simply check against newly introduced character of participant :-)   
                takeover = false
              end
            end

            #if  do the takeover
            if takeover
              if !battle.location.settlement.nil?
                runloop.say "Check for possible takeover of settlement ID #{ battle.location.settlement.id }."
                
                #do the takeover
                old_owner = target_settlement.owner
                new_owner = if winner_leader.can_takeover_settlement? && (battle.location.fortress? || battle.location.region.settleable_by?(winner_leader))
                              winner_leader
                            else
                              candidate = winner_faction.takeover_candidate_with_largest_army
                              candidate.nil?  ? nil : candidate.army.owner
                            end

                if !new_owner.nil?
                  runloop.say "Execute takeover of settlement ID #{ battle.location.settlement.id }."
                             
                  target_settlement.new_owner_transaction(new_owner)
                
                  runloop.say "Send takeover messages."

                  #message for old and new owner
                  Messaging::Message.generate_lost_fortress_message(target_settlement, old_owner, new_owner) unless old_owner.nil? || old_owner.npc?
                  Messaging::Message.generate_gained_fortress_message(target_settlement, old_owner, new_owner) unless new_owner.nil? || new_owner.npc?

                  runloop.say "Takeover finished."
                else
                  runloop.say "No takeover possible."    
                end
              end
            end
          end
          
          # suspend all losers of battle
          loser_faction = battle.other_faction(winner_faction.id)
          runloop.say "Loser faction #{loser_faction.id}, Participants #{loser_faction.participants.count}"
          
          if !loser_faction.nil?
            loser_faction.participants.each do |participant|
              if !participant.army.nil?  
                participant.army.suspension_ends_at = DateTime.now.advance(:minutes => GAME_SERVER_CONFIG['ap_regeneration_duration'])
                if !participant.army.save
                  raise InternalServerError.new('Failed to suspend the army after battle loss')
                end
                
                runloop.say "Army #{participant.army.id} '#{participant.army.name}' suspended from #{DateTime.now} till #{DateTime.now.advance(:minutes => GAME_SERVER_CONFIG['ap_regeneration_duration'])}"
              end
            end
          end

          runloop.say "Check for artifacts"
          artifact = battle.artifact
          if artifact.nil?
            runloop.say "No artifact available"
          else
            runloop.say "Artifact available: check for capturing artifact id #{artifact.id}"
            old_artifact_owner = artifact.owner
            if !artifact.army.nil? && !artifact.army.battle_participant.nil? && artifact.army.battle_participant.faction == loser_faction
              runloop.say "Won Battle for Artifact"
              if artifact.capture_by_character(winner_leader)
                Messaging::Message.generate_artifact_captured_message(winner_leader)
              else
                Messaging::Message.generate_artifact_jumped_message(winner_leader)
              end
              Messaging::Message.generate_artifact_stolen_message(old_artifact_owner) unless old_artifact_owner.npc?
            else
              artifact.make_invisible if artifact.owner.npc?
            end
          end

          runloop.say "Calculate XP for both factions"
          battle.calculate_character_results

          runloop.say "Propagate XP to characters"
          battle.propagate_character_results_to_character

        end

        runloop.say "Count victory and defeat in participating characters"
        battle.count_victory_and_defeat

        ## generate message for participants
        runloop.say "Battle done, starting to send out messages"
        battle_summary = Ticker::BattleHandler::BattleSummary.new(battle)
        battle_summary.send_battle_report_messages()


        runloop.say "Cleanup armies and battle"

        ## cleanup of the destroyed armies and battle object
        cleanup_armies(battle)
        cleanup_battle(battle)
      else
        #update the leaders
        battle.factions.each do |faction|
          if !faction.update_leader
            runloop.say "Failed to update the leader", Logger::ERROR
          end
        end

        runloop.say "Check for artifacts"
        artifact = battle.artifact
        unless artifact.nil?
          runloop.say "Artifact available: check for stealing artifact id #{artifact.id}"
          old_artifact_owner = artifact.owner

          if !battle.faction_owning_artifact(artifact).nil? && !battle.faction_owning_artifact(artifact).opposing_faction.nil?
            new_artifact_owner = battle.faction_owning_artifact(artifact).opposing_faction.leader
          end

          unless new_artifact_owner.nil?
            success = battle.check_for_artifact_stealing(artifact)
            runloop.say "Check for artifacts stealing: #{success}"
            if success == true
              Messaging::Message.generate_artifact_captured_message(new_artifact_owner)
              Messaging::Message.generate_artifact_stolen_message(old_artifact_owner) unless old_artifact_owner.npc?
            elsif success == false # hack: don't do anything if success is nil
              Messaging::Message.generate_artifact_jumped_message(new_artifact_owner)
              Messaging::Message.generate_artifact_stolen_message(old_artifact_owner) unless old_artifact_owner.npc?
            end
          end
        else
          runloop.say "During Battle: Artifact not available"
        end

        garrison_army = battle.garrison
        if !garrison_army.nil? && !garrison_army.home.nil?
          garrison_army.home.wear_down_condition
          garrison_army.home.save
        end

        #schedule next round
        battle.schedule_next_round
        battle.save
        battle.create_event_for_next_round
        runloop.say "Battle not done, scheduled and created next event"
      end
      
      #  LET ARMIES RETREAT AND CLEANUP PARTICIPANT AND ARMY
      
      # CONTINUE BATTLE?
      # YES: CREATE EVENT FOR NEXT ROUND
      # NO: CLEANUP PARTICIPANTS, FACTIONS AND BATTLE; RESET ARMIES
      
      runloop.say "Battle round completed, cleaning up and destroying event."      

      #reenable garbage collection if it was enabled before
      GC.enable unless gcstate

      #runloop.say "WARNING event is currently not beeing destroyed for debug purposes"
      event.destroy
      runloop.say "Battle handler completed."

    end
  end

  #deletes armies that no longer exists (or marks them as removed)
  def cleanup_armies(battle)
    battle.armies.each do |army|
      if army.empty? && !army.garrison?
        if GAME_SERVER_CONFIG['military_only_flag_destroyed_armies']
          army.removed = true
          raise InternalServerError.new('Failed to flag an army as removed') unless army.save
        else
          army.destroy
        end
      else
        #remove battle id  !!! battle_id must be set to nil for removing army from battle
        army.battle = nil
        raise InternalServerError.new('Failed to set the battle id in the army to null') unless army.save
      end
    end

    if GAME_SERVER_CONFIG['military_only_flag_destroyed_armies']
      runloop.say "Flaged destroyed armies as 'removed'"
    else
      runloop.say "Deleted destroyed armies from the database"
    end

  end

  #destorys the battle and all Military::Battle* subobject
  def cleanup_battle(battle)
    if GAME_SERVER_CONFIG['military_only_flag_destroyed_battles']
      battle.removed = true
      raise InternalServerError.new('Failed to flag an battle as removed') unless battle.save
      runloop.say "Flaged destroyed battle as 'removed'"
    else
      battle.destroy
      runloop.say "Deleted finished battle from the database"
    end
  end

end