class Shop::SpecialOffersTransaction < ActiveRecord::Base

  belongs_to :character,      :class_name => "Fundamental::Character", :foreign_key => "character_id",                   :inverse_of => :special_offers_transactions
  has_one    :purchase,       :class_name => "Shop::Purchase",         :foreign_key => "special_offers_transaction_id",  :inverse_of => :special_offers_transaction
  belongs_to :special_offer,  :class_name => "Shop::SpecialOffer",     :foreign_key => "external_offer_id"

  before_save :check_state

  def check_state
    if self.paid? && self.redeemed?
      self.state = Shop::Transaction::STATE_PAID_AND_REDEEMED
    end
  end

  def paid?
    !self.paid_at.nil?
  end

  def redeemed?
    !self.redeemed_at.nil?
  end
end
