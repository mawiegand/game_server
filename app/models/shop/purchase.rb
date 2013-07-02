class Shop::Purchase < ActiveRecord::Base

  belongs_to :character,                  :class_name => "Fundamental::Character",          :foreign_key => "character_id",                   :inverse_of => :purchases
  belongs_to :special_offers_transaction, :class_name => "Shop::SpecialOffersTransaction",  :foreign_key => "special_offers_transaction_id",  :inverse_of => :purchase

  def redeemed?
    !redeemed_at.nil? && redeemed_at < DateTime.now
  end

  def special_offer
    Shop::SpecialOffer.find_by_external_offer_id(self.external_offer_id)
  end
end
