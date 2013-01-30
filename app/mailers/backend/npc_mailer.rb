class Backend::NpcMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "npcjob@gs02.wack-a-doo.de" : "npcjob@test1.wack-a-doo.de"
  
  def npc_placement_report(report)
    @report = report
    
    mail(:to => GAME_SERVER_CONFIG['status_email_recipient'], :subject => "[#{Rails.env}] #{@report[:num_npcs_placed]} new NPC armies have been placed for a total of #{@report[:num_npcs]}.")
  end
end
