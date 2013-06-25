class Shop::Purchase < ActiveRecord::Base

  belongs_to :character,                  :class_name => "Fundamental::Character",          :foreign_key => "character_id",                   :inverse_of => :purchases
  belongs_to :special_offers_transaction, :class_name => "Shop::SpecialOffersTransaction",  :foreign_key => "special_offers_transaction_id",  :inverse_of => :purchase
  belongs_to :special_offer,              :class_name => "Shop::SpecialOffer",              :foreign_key => "offer_id",                       :inverse_of => :purchases


  def redeemed?
    !redeemed_at.nil? && redeemed_at < DateTime.now
  end
end
