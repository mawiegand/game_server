class Shop::MoneyTransaction < ActiveRecord::Base
  
  scope :offer, lambda { |id| where(offer_id: id) }
  
end
