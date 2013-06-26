class Shop::SpecialOffer < ActiveRecord::Base

  def credit_to(character)
    logger.debug "--->credited special_offer to character " + character.inspect
  end

end
