class Shop::SpecialOffer < ActiveRecord::Base

  has_many :purchases, :class_name => "Shop::Purchase", :foreign_key => "offer_id", :inverse_of => :special_offer

  def credit_to(character)
    logger.debug "--->credited special_offer to character " + character.inspect
  end

end
