class Backend::MessageDeletionMailer < ActionMailer::Base
  default from: Rails.env.production? ?  "messagedeletion@gs02.wack-a-doo.de" : "messagedeletion@test1.wack-a-doo.de"
  
  def message_deletion_report(report)
    @report = report
    
   mail(:to => 'patrick@5dlab.com', :subject => "[#{Rails.env}] #{@report[:deleted_inbox_entry_count]} inbox entries and #{@report[:deleted_outbox_entry_count]} outbox entries have been deleted.")
  end
end