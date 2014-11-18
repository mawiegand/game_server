require 'five_d'

class Shop::MoneyTransaction < ActiveRecord::Base

  scope :offer,          lambda { |id|   where(offer_id: id) }
  scope :since_date,     lambda { |date| where('updatetstamp >= ?', date) }
  scope :completed,      where("transaction_state LIKE 'completed'")
  scope :no_charge_back, where('chargeback < 0.5')
  scope :charge_back,    where('chargeback >= 0.5')

  def completed?
    return transaction_state == 'completed'
  end

  def chargeback?
    return (chargeback || 0) >= 0.5
  end

  def send_chargeback_alert
    self.sent_mail_alert = true
    self.save

    mail = Backend::StatusMailer.sent_chargeback_alert(self)
    mail.deliver unless mail.nil?
  end

  def unsent_chargeback_alert?
    1.5 > (self.chargeback || 0) && (self.chargeback || 0) > 0.5 && !self.sent_mail_alert?
  end

  def send_special_offer_alert
    self.sent_special_offer_alert = true
    self.save

    mail = Backend::StatusMailer.sent_special_offer_alert(self)
    mail.deliver unless mail.nil?
  end

  def unsent_special_offer_alert?
    self.offer_category == "1" && self.chargeback < 0.5 && !self.sent_special_offer_alert?
  end

  # track purchases with prisori
  # attention: tracking is presently done in a central place at the identity provider
  def track_purchase
    return true   if tracked?
    return true   if chargeback?
    return true   unless completed?
    return true   if sandbox?
    

    tracker = FiveD::EventTracker.new

    tracker.track('purchase', 'revenue', {
      user_id:              self.partner_user_id || nil,
      pur_provider:         self.carrier,
      pur_gross:            self.gross,
      pur_currency:         self.gross_currency,
      pur_country_code:     self.country,
      pur_earnings:         self.earnings,
      pur_product_sku:      self.offer_id,
      pur_product_category: self.offer_category,
      invoice_id:           self.invoice_id,
      timestamp:            self.tstamp || DateTime.now
    });

    self.tracked = true

    true
  end

  # track purchases with prisori
  # attention: tracking is presently done in a central place at the identity provider
  def track_chargeback
    return true   if chargeback_tracked?
    return true   unless chargeback?
    return true   if sandbox?
    

    tracker = FiveD::EventTracker.new

    tracker.track('chargeback', 'revenue', {
      user_id:              self.partner_user_id || nil,
      pur_provider:         self.carrier,
      pur_gross:            self.gross,
      pur_currency:         self.gross_currency,
      pur_country_code:     self.country,
      pur_earnings:         self.earnings,
      pur_product_sku:      self.offer_id,
      pur_product_category: self.offer_category,
      invoice_id:           self.invoice_id,
      timestamp:            self.tstamp || DateTime.now
    });

    self.chargeback_tracked = true

    true
  end

end
