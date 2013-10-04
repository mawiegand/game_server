class Shop::MoneyTransaction < ActiveRecord::Base
  
  scope :offer,          lambda { |id|   where(offer_id: id) }
  scope :since_date,     lambda { |date| where('updatetstamp >= ?', date) }
  scope :completed,      where("transaction_state LIKE 'completed'")
  scope :no_charge_back, where('chargeback < 0.5')
  scope :charge_back,    where('chargeback > 0.5')

  def send_chargeback_alert
    self.sent_mail_alert = true
    self.save

    Backend::StatusMailer.sent_chargeback_alert(self).deliver
  end

  def unsent_chargeback_alert?
    1.5 > self.chargeback && self.chargeback > 0.5 && !self.sent_mail_alert?
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

end
