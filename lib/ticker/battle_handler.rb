require 'ticker/runloop'
require 'awe_native_extensions'
require 'ticker/battle_handler_awe_factory'
require 'ticker/battle_handler_result_extractor'
require 'ticker/battle_handler_message_factory'

class Ticker::BattleHandler
  
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
    battle = Military::Battle.find(event.local_event_id)
    if battle.nil?
      #runloop.say "Could not find battle for id #{ event.local_event_id }.", Logger::ERROR
    else
      #switch off the garbage collection, to prevent the garbage collector marking not initialized SWIG obects
      gcstate = GC.disable

      #runloop.say "Process battle round #{ battle.battle_rounds_count || 0} for battle #{ battle.id } at loc #{ battle.location_id} in reg #{ battle.region_id }."
    
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
      awe_battle_calculator.callculateOneTick(awe_battle)  # execute round
      
      ## extract and store results in database & handle retreat
      extract_results_from_awe_battle(awe_battle, battle)

      ## check if the battle is over
      if battle.battle_done?

        runloop.say "Battle done, starting to send out messages"

        ## generate message for participants
        generate_messages_for_battle(awe_battle, battle)

        ## get winner of the battle
        winner_faction = battle.winner_faction
        winner_faction.update_leader
        winner_leader = nil
        if !winner_faction.nil?
          winner_leader = winner_faction.leader
        end

        #if there is a winner
        if !winner_faction.nil?

          raise InternalServerError.new('A faction won a battle but did not have a leader') if winner_leader.nil?

          #CALL: take-over-handler
          #        - decides, whether a takeover should happen (settlemenet involved & lost , winners still have a survivor)
          #        - decides, WHO should obtain the settlement (initiator; attacked first, otherwise the strongest winner)
          #        CALL: settlement.new_owner_transaction(character) with character of new owner

          #check if there was a battle over a settlement
          target_settlement = battle.targeted_settlement
          
          if !target_settlement.nil?
            #check if the battle location is owned by a participant of the winner faction
            takeover = true
            winner_faction.participants.each do |participant|
              if participant.army.owner_id == battle.location.owner_id
                takeover = false
              end
            end

            #if not do the takeover
            if takeover
              if !battle.location.settlement.nil?
                #do the takeover
                target_settlement.new_owner_transaction(winner_leader)
              end
            end
          end

        end

        ## cleanup of the destroyed armies
        cleanup_armies(battle)
        ## cleanup of the battle object
        cleanup_battle(battle)
        
      else
        #update the leaders
        battle.factions.each do |faction|
          if !faction.update_leader
            runloop.say "Failed to update the leader", Logger::ERROR
          end
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
      if (army.empty? && !army.garrison)
        if GAME_SERVER_CONFIG['military_only_flag_destroyed_armies']
          army.removed = true
          if !army.save
            raise InternalServerError.new('Failed to flag an army as removed')
          end
        else
          army.destroy
        end
      else
        #remove battle id
        army.battle_id = 0
        army.mode = 0
        if !army.save
          raise InternalServerError.new('Failed to set the battle id in the army to 0')
        end
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
      if !battle.save
        raise InternalServerError.new('Failed to flag an battle as removed')
      end
      runloop.say "Flaged destroyed battle as 'removed'"
    else
      battle.destroy
      runloop.say "Deleted finished battle from the database"
    end
  end

end
