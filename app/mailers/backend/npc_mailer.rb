class Backend::NpcMailer < ActionMailer::Base
  default from: "npcjob@wack-a-doo.de"
  
  def npc_placement_report(report)
    @report = report
    
    mail(:to => GAME_SERVER_CONFIG['status_email_recipient'], :subject => "#{@report[:num_npcs]} NPC armies have been placed.")
  end
end
