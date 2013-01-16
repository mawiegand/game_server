class Backend::PlayerDeletionMailer < ActionMailer::Base

  default from: Rails.env.production? ?  "playerdeletion@gs02.wack-a-doo.de" : "playerdeletion@test1.wack-a-doo.de"
  
  def player_deletion_report(report)
    @report = report
    
    mail(:to => GAME_SERVER_CONFIG['status_email_recipient'], :subject => "#{@report[:deleted_players].count} players have been deleted.")
  end
end
