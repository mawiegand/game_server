require 'notification_ticker/runloop'

class NotificationTicker::RetentionMailHandler
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def notification_type
    "retention_mail"
  end
  
  def process
    runloop.say "Process retention mail handler."
         
    Fundamental::Character.all.each do |character|
      character.check_for_retention_mail
    end     
         
    runloop.say "Retention mail handler completed."
  end
end

