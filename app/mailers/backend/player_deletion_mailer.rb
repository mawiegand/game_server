class Backend::PlayerDeletionMailer < ActionMailer::Base

  default from: Rails.env.production? ?  "playerdeletion@gs04.wack-a-doo.de" : "playerdeletion@test1.wack-a-doo.de"
  
  def player_deletion_report(report)
    @report = report
    mail(:to => GAME_SERVER_CONFIG['status_email_recipient'], :subject => "[#{Rails.env}] #{@report[:deleted_players].count} players and #{@report[:removed_settlements].count} npc settlements have been deleted.")
  end

  def player_remove_claimed_settlements_report(report)
    @report = report
    mail(:to => GAME_SERVER_CONFIG['status_email_recipient'], :subject => "[#{Rails.env}] #{@report[:removed_not_started_players].count} claimed settlements and big chiefs have been removed.")
  end

end
