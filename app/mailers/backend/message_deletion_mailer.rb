class Backend::MessageDeletionMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "playerdeletion@gs02.wack-a-doo.de" : "playerdeletion@test1.wack-a-doo.de"
  
  def message_deletion_report(report)
    @report = report
    
   mail(:to => 'cron@5dlab.com', :subject => "[#{Rails.env}] #{@report[:deleted_inbox_entries].count} inbox entries and #{@report[:deleted_outbox_entries].count} outbox entries have been deleted.")
  end
end
