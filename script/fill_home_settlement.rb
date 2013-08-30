#!/usr/bin/env ruby
#
# Helper script to generate a stub for a new gamestate class and manager
# that are derived from the (abstract) entity base class and manager base 
# class.
#
# Example: ./scripts/generate_objectivec_stub Fundamental::Character

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

if ARGV[0].blank?
  abort "Provide a character id as the only argument to the script."
end

character_id = eval(ARGV[0])


character = Fundamental::Character.find(character_id)

if character.nil? 
  abort "character #{character_id} not found"
end

if character.playtime > 20*60.0 || character.score >= 50
  abort "character #{character_id} seems to be already playing"
end

credit_to(character)


def credit_to(character)
  stone_id        =    0
  wood_id         =    1
  fur_id          =    2
  cash_id         =    3
  cash_amount     =  300
  resource_amount = 5000
    
  slots = {
    1 => {
      id: 21,
      level: 10,
    },
    2 => {
      id: 23,
      level: 1,
    },
  }
  
  units = [
    {
      id: 0,
      number: 20,
    },
  ]
      
  settlement = character.bases[0]
  
  slots.each do |slot_num, specs|
    slot = settlement.slots[slot_num]
    
    if (slot.empty?)
      slot.create_building(specs[:id])
      logger.debug "FILL HOME BASE: Created building with id #{specs[:id]} in slot #{slot.inspect}."
    end
    
    while slot.level < specs[:level]
      slot.upgrade_building
    end
  end
  
  logger.info("FILL HOME BASE: Created new outpost for character #{ character.id }: #{ character.name }.")

  
  # credit resources and golden frogs
  character.resource_pool.modify_resources_atomically({
    stone_id => resource_amount,
    wood_id  => resource_amount,
    fur_id   => resource_amount,      
    cash_id  => cash_amount,
  })

  logger.info("FILL HOME BASE: Credited resources to character #{ character.id }: #{ character.name }.")
  
  
  # credit units
  units.each do |specs|
    home_base.add_units_to_garrison(specs[:id], specs[:number])
  end

  logger.info("FILL HOME BASE: Credited units to character #{ character.id }: #{ character.name }.")
    
end
