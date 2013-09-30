class Shop::SpecialOffer < ActiveRecord::Base

  def find_settleable_location_near_home_base(character)
    Map::Location.location_for_oupost_in_starter_package(character)
  end

  def self.buyable_by_character(character)
    if character.show_special_offers?         # if character is in dialog time interval (after finished tutorial)
      buyable_offers = Shop::SpecialOffer.all.select do |offer|   # show offers, that the user didn't buy yet
        character.purchases.where('external_offer_id = ? and redeemed_at is not null', offer.external_offer_id).empty?
      end
      buyable_offers.map { |offer| offer.attributes }
    else
      []
    end
  end

  def buyable_by_character(character)
    if character.show_special_offers?         # if character is in dialog time interval (after finished tutorial)
      character.purchases.where('external_offer_id = ? and redeemed_at is not null', self.external_offer_id).empty?
    else
      false
    end
  end

  def credit_to(character)

    special_offer_rules = GameRules::Rules.the_rules.special_offer

    # create outpost
    location = find_settleable_location_near_home_base(character)
    settlement = Settlement::Settlement.create_settlement_at_location(location, Settlement::Settlement::TYPE_OUTPOST, character)

    special_offer_rules[:outpost].each do |slot_num, specs|
      slot = settlement.slots.with_num(slot_num).first
      
      if slot.empty?
        slot.create_building(specs[:id])
        logger.debug "STARTER PACKAGE: Created building with id #{specs[:id]} in slot #{slot.inspect}."
      end
      
      while slot.level < specs[:level]
        slot.upgrade_building
      end
    end
    logger.info("STARTER PACKAGE: Created new outpost for character #{ character.id }: #{ character.name }.")

    
    # credit resources and golden frogs
    character.resource_pool.modify_resources_atomically(special_offer_rules[:start_resources])
    logger.info("STARTER PACKAGE: Credited resources to character #{ character.id }: #{ character.name }.")
    
    
    # credit units
    #home_base.add_units_to_garrison(unit1_id, unit1_amount)
    #home_base.add_units_to_garrison(unit2_id, unit2_amount)
    #logger.info("STARTER PACKAGE: Credited units to character #{ character.id }: #{ character.name }.")
    
    # credit resource effects
    special_offer_rules[:production_bonus].each do |bonus|
      bonus_offer = Shop::BonusOffer.find_by_id(bonus[:bonus_offer_id])
      if !bonus_offer.nil?
        Effect::ResourceEffect.create_or_extend_shop_effect(character, bonus_offer.resource_id, bonus_offer.bonus, bonus[:duration], bonus_offer.id)
      end
    end

    # credit construction speedup effect
    if !special_offer_rules[:construction_bonus].nil?
      Effect::ConstructionEffect.create_or_extend_shop_effect(character, special_offer_rules[:construction_bonus][:amount], special_offer_rules[:construction_bonus][:duration])
    end
    
  end

end
