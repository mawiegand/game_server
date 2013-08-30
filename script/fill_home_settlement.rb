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



def credit_to(character)
  stone_id        =    0
  wood_id         =    1
  fur_id          =    2
  cash_id         =    3
  cash_amount     =  300
  resource_amount = 75000
    
  slots = {
    1 => {
      id: 2,
      level: 20,
    },
    2 => {
      id: 0,
      level: 20,
    },
    3 => {
      id: 19,
      level: 18,
    },
    4 => {
      id: 20,
      level: 18,
    },
    5 => {
      id: 16,
      level: 10,
    },
    6 => {
      id: 15,
      level: 10,
    },
    7 => {
      id: 18,
      level: 10,
    },
    8 => {
      id: 16,
      level: 10,
    },
    9 => {
      id: 15,
      level: 10,
    },
    10 => {
      id: 18,
      level: 10,
    },
    11 => {
      id: 2,
      level: 10,
    },
    12 => {
      id: 9,
      level: 10,
    },
    13 => {
      id: 17,
      level: 10,
    },
    14 => {
      id: 17,
      level: 10,
    },
    15 => {
      id: 2,
      level: 10,
    },
    16 => {
      id: 12,
      level: 10,
    },
    17 => {
      id: 12,
      level: 10,
    },
    18 => {
      id: 30,
      level: 10,
    },
    19 => {
      id: 8,
      level: 10,
    },
    20 => {
      id: 2,
      level: 10,
    },
    21 => {
      id: 12,
      level: 10,
    },
    22 => {
      id: 17,
      level: 10,
    },
    23 => {
      id: 14,
      level: 10,
    },
    24 => {
      id: 5,
      level: 10,
    },
    25 => {
      id: 11,
      level: 10,
    },
    26 => {
      id: 14,
      level: 10,
    },
    27 => {
      id: 13,
      level: 10,
    },
    28 => {
      id: 14,
      level: 10,
    },
    29 => {
      id: 16,
      level: 10,
    },
    30 => {
      id: 15,
      level: 10,
    },
    31 => {
      id: 18,
      level: 10,
    },
    32 => {
      id: 14,
      level: 10,
    },
    33 => {
      id: 29,
      level: 4,
    },
    34 => {
      id: 14,
      level: 10,
    },
    35 => {
      id: 16,
      level: 10,
    },
    36 => {
      id: 15,
      level: 10,
    },
    37 => {
      id: 18,
      level: 10,
    },
    38 => {
      id: 16,
      level: 10,
    },
    39 => {
      id: 15,
      level: 10,
    },
    40 => {
      id: 18,
      level: 10,
    },
    
  }
  
  units = [
    {
      id: 3,
      number: 250,
    },
    {
      id: 7,
      number: 250,
    },
    {
      id: 11,
      number: 250,
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

character = Fundamental::Character.find(character_id)

if character.nil? 
  abort "character #{character_id} not found"
end

if character.playtime > 20*60.0 || character.score >= 50
  abort "character #{character_id} seems to be already playing"
end

credit_to(character)



