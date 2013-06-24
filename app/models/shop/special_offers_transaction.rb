class Shop::SpecialOffersTransaction < ActiveRecord::Base

  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :special_offers_transactions

  def after_initialize
    self.state = Shop::Transaction::STATE_CREATED
  end

end
