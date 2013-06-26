class Backend::StatusMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "status@gs02.wack-a-doo.de" : "status@test1.wack-a-doo.de"
  
  def sent_chargeback_alert(transaction)
    if Rails.env.production?
      @transaction = transaction

      mail(:to      => GAME_SERVER_CONFIG['chargeback_email_recipient'],
           :subject => "[#{Rails.env}] Transaktion mit Chargeback-Status gefunden.")
    end
  end

  def sent_special_offer_alert(transaction)
    if Rails.env.production? || true
      @transaction = transaction

      mail(:to      => GAME_SERVER_CONFIG['sales_email_recipient'],
           :subject => "[#{Rails.env}] Transaktion mit Kauf eines Premiumpakets gefunden.")
    end
  end
end
