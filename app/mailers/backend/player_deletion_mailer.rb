class Backend::PlayerDeletionMailer < ActionMailer::Base

  default from: Rails.env.production? ?  "playerdeletion@gs02.wack-a-doo.de" : "playerdeletion@test1.wack-a-doo.de"
  
  def player_deletion_report(report)
    @report = report
    
    mail(:to => 'p@trick-fox.de', :subject => "#{@report[:deleted_players].count} players and #{@report[:deleted_settlements].count} settlements have been deleted.")
  end
end
