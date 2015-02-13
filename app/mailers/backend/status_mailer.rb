class Backend::StatusMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "status@gs08.wack-a-doo.de" : "status@test1.wack-a-doo.de"
  
  def sent_chargeback_alert(transaction)
    @transaction = transaction

    if Rails.env.production?
      mail(:to      => GAME_SERVER_CONFIG['chargeback_email_recipient'],
           :subject => "[#{Rails.env}] Transaktion mit Chargeback-Status gefunden.")
    end
  end

  def sent_special_offer_alert(transaction)
    @transaction = transaction

    if Rails.env.production?
      mail(:to      => GAME_SERVER_CONFIG['sales_email_recipient'],
           :subject => "[#{Rails.env}] Transaktion mit Kauf eines Premiumpakets gefunden.")
    end
  end
  
  def send_ip_resolution_alert(ip)
    @ip = ip

    if Rails.env.production?
      mail(:to      => GAME_SERVER_CONFIG['status_email_recipient'],
           :subject => "[#{Rails.env}] GEO-Aufloesung waehrend der Registrierung fehlgeschlagen.")
    end
  end
end
