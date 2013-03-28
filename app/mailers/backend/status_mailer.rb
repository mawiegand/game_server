class Backend::StatusMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "status@gs02.wack-a-doo.de" : "status@test1.wack-a-doo.de"
  
  def sent_chargeback_alert(transaction)
    @transaction = transaction

    mail(:to      => GAME_SERVER_CONFIG['status_email_recipient'],
         :subject => "[#{Rails.env}] Chargeback found in transactions.")
  end
end
