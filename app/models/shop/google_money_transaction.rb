require 'five_d'

class Shop::GoogleMoneyTransaction < ActiveRecord::Base
  
  after_save :track_purchase  
  
  def track_purchase
    return true   if tracked?
    return true   if test?

    tracker = FiveD::EventTracker.new

    tracker.track('purchase', 'revenue', {
      user_id:              self.identifier || nil,
      platform:             "android",
      pur_provider:         "google",
      pur_gross:            self.price,
      pur_currency:         self.currency,
      pur_earnings:         (self.price.to_f * 0.6).to_s,
      pur_product_sku:      self.google_product_id,
      invoice_id:           self.google_payment_token,
      pur_receipt_identifier: self.google_payment_token,
      timestamp:            self.created_at || DateTime.now
    });

    self.tracked = true
    self.save

    true
  end
  
end
