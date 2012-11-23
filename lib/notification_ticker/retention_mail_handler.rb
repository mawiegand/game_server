require 'notification_ticker/runloop'
require 'identity_provider/access'

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
    runloop.say "Retention mail handler process started"

    ip_access = IdentityProvider::Access.new(
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes: ['5dentity'],
    )
         
    Fundamental::Character.non_npc.retention_played_too_short.retention_no_mail_pending.each do |character|
      if character.retention_mails.where("mail_type = 'played_too_short'").empty?
        mail = character.retention_mails.create({
          mail_type: 'played_too_short'
        })
        ip_access.deliver_retention_mail(mail)
        runloop.say "Sent retention mail to character id: #{character.id}, type: #{mail.mail_type}"
      end      
    end     
         
    Fundamental::Character.non_npc.retention_paused_too_long.retention_no_mail_pending.each do |character|
      if(!character.max_conversion_state.nil? &&
          character.max_conversion_state != 'registered' &&
          character.max_conversion_state != 'logged_in_once' &&
          character.max_conversion_state != 'ten_minutes')
        mail = character.retention_mails.create({
          mail_type: 'paused_too_long'
        })
        ip_access.deliver_retention_mail(mail)
        runloop.say "Sent retention mail to character id: #{character.id}, type: #{mail.mail_type}"
      end      
    end     
         
    # Fundamental::Character.non_npc.retention_getting_inactive.retention_no_mail_pending.each do |character|
      # if(!character.max_conversion_state.nil? &&
          # character.max_conversion_state != 'registered' &&
          # character.max_conversion_state != 'logged_in_once' &&
          # character.max_conversion_state != 'ten_minutes')
        # credit_reward = (character.max_conversion_state == "paying") ? 16 : 12
        # mail = character.retention_mails.create({
          # mail_type: 'retention_getting_inactive',
          # credit_reward: credit_reward,
        # })
        # mail.redeem_credit_reward if credit_reward > 0
        # ip_access.deliver_retention_mail(mail)
        # runloop.say "Sent retention mail to character id: #{character.id}, type: #{mail.mail_type}, credit_reward: #{credit_reward}"
      # end      
    # end     
         
    runloop.say "Retention mail handler process completed"
  end
end

