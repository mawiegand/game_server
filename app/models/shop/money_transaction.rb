class Shop::MoneyTransaction < ActiveRecord::Base
  
  scope :offer,          lambda { |id|   where(offer_id: id) }
  scope :since_date,     lambda { |date| where('updatetstamp >= ?', date) }
  scope :completed,      where("transaction_state LIKE 'completed'")
  scope :no_charge_back, where('chargeback < 0.5')
  scope :charge_back,    where('chargeback > 0.5')
  
end
