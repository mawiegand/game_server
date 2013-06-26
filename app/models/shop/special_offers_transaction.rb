class Shop::SpecialOffersTransaction < ActiveRecord::Base

  belongs_to :character,      :class_name => "Fundamental::Character", :foreign_key => "character_id",                   :inverse_of => :special_offers_transactions
  has_one    :purchase,       :class_name => "Shop::Purchase",         :foreign_key => "special_offers_transaction_id",  :inverse_of => :special_offers_transaction
  belongs_to :special_offer,  :class_name => "Shop::SpecialOffer",     :foreign_key => "offer_id"

end
