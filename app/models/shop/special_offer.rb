class Shop::SpecialOffer < ActiveRecord::Base

  def find_settleable_location_near_home_base(character)
    Map::Location.location_for_oupost_in_starter_package(character)
  end

  def self.buyable_by_character(character)
    if character.show_special_offers?
      Shop::SpecialOffer.all
    else
      []
    end
  end

  def credit_to(character)
    stone_id        =    0
    wood_id         =    1
    fur_id          =    2
    cash_id         =    3
    cash_amount     =  300
    resource_amount = 5000
    
    unit1_id        =    0
    unit1_amount    =   20
    unit2_id        =    4
    unit2_amount    =   50
    
    production_bonus_amount   = 0.15
    production_bonus_duration = 120
    
    slots = {
      1 => {
        id: 21,
        level: 10,
      },
      2 => {
        id: 23,
        level: 1,
      },
      3 => {
        id: 1,
        level: 10,
      },
      4 => {
        id: 1,
        level: 10,
      },
      5 => {
        id: 1,
        level: 10,
      },
      6 => {
        id: 1,
        level: 10,
      },
      7 => {
        id: 1,
        level: 10,
      },
      8 => {
        id: 1,
        level: 9,
      },
      9 => {
        id: 1,
        level: 8,
      },
      10 => {
        id: 4,
        level: 7,
      },
    }
        
    home_base = character.bases[0]

    # create outpost
    location = find_settleable_location_near_home_base(character)
    settlement = Settlement::Settlement.create_settlement_at_location(location, 3, character)  # 3: outpost
    
    slots.each do |slot_num, specs|
      slot = settlement.slots[slot_num]
      
      if (slot.empty?)
        slot.create_building(specs[:id])
        logger.debug "STARTER PACKAGE: Created building with id #{specs[:id]} in slot #{slot.inspect}."
      end
      
      while slot.level < specs[:level]
        slot.upgrade_building
      end
    end
    
    logger.info("STARTER PACKAGE: Created new outpost for character #{ character.id }: #{ character.name }.")

    
    # credit resources and golden frogs
    character.resource_pool.modify_resources_atomically({
      stone_id => resource_amount,
      wood_id  => resource_amount,
      fur_id   => resource_amount,      
      cash_id  => cash_amount,
    })

    logger.info("STARTER PACKAGE: Credited resources to character #{ character.id }: #{ character.name }.")
    
    
    # credit units
    home_base.add_units_to_garrison(unit1_id, unit1_amount)
    home_base.add_units_to_garrison(unit2_id, unit2_amount)

    logger.info("STARTER PACKAGE: Credited units to character #{ character.id }: #{ character.name }.")
    
    # credit resource effects
    Effect::ResourceEffect.create_or_extend_shop_effect(character, stone_id, production_bonus_amount, production_bonus_duration)
    Effect::ResourceEffect.create_or_extend_shop_effect(character, wood_id,  production_bonus_amount, production_bonus_duration)
    Effect::ResourceEffect.create_or_extend_shop_effect(character, fur_id,   production_bonus_amount, production_bonus_duration)
    
    # credit construction speedup effect
    
  end

end
