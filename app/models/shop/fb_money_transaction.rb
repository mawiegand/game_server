require 'five_d'


class Shop::FbMoneyTransaction < ActiveRecord::Base
  
  after_save :track_purchase  
  
  def track_purchase
    return true   if tracked?
    return true   if test?

    tracker = FiveD::EventTracker.new

    tracker.track('purchase', 'revenue', {
      user_id:              self.identifier || nil,
      platform:             "facebook",
      pur_provider:         "facebook",
      pur_gross:            self.amount,
      pur_currency:         self.currency,
      pur_country_code:     self.country,
      pur_earnings:         self.amount.to_f * 0.6,
      pur_product_sku:      self.fb_offer_id,
      invoice_id:           self.payment_id,
      timestamp:            self.created_at || DateTime.now
    });

    self.tracked = true
    self.save

    true
  end
  
end
