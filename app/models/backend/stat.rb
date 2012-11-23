class Backend::Stat < ActiveRecord::Base
  
  before_create :recalc_all_stats
  
  def self.activity_period
    1.weeks
  end
  
  def self.update_all_character_stats
    Fundamental::Character.update_all_conversions
    Fundamental::Character.update_all_credits_spent
  end
 
  
  def self.update_all_cohorts
    Backend::Stat.find(:all).each do |stat|
      stat.month_num_registered = stat.month_num_logged_in_once = stat.month_num_ten_minutes = stat.month_num_logged_in_two_days = stat.month_num_long_term_active = stat.month_num_active = stat.month_num_paying = stat.month_credits_spent = stat.month_gross = stat.month_finished_quests = stat.month_inactive= 0
      characters = Fundamental::Character.non_npc.where([ 'created_at <= ? AND created_at > ?', stat.created_at, stat.created_at - 1.months ])
      characters.each do |character|
        stat.month_num_registered         += 1   if character.max_conversion_state == "registered"
        stat.month_num_logged_in_once     += 1   if character.max_conversion_state == "logged_in_once"
        stat.month_num_ten_minutes        += 1   if character.max_conversion_state == "ten_minutes"
        stat.month_num_logged_in_two_days += 1   if character.max_conversion_state == "logged_in_two_days"
        stat.month_num_active             += 1   if character.max_conversion_state == "active"
        stat.month_num_long_term_active   += 1   if character.max_conversion_state == "long_term_active"
        stat.month_num_paying             += 1   if character.max_conversion_state == "paying"
        stat.month_credits_spent          += character.credits_spent_total || 0
        stat.month_gross                  += character.gross || 0.0
        stat.month_finished_quests        += character.num_finished_quests || 0
        stat.month_inactive               += 1   if character.last_login_at < Time.now - Backend::Stat.activity_period
      end

      stat.day_num_registered = stat.day_num_logged_in_once = stat.day_num_ten_minutes = stat.day_num_logged_in_two_days = stat.day_num_long_term_active = stat.day_num_active = stat.day_num_paying = stat.day_credits_spent = stat.day_gross = stat.day_finished_quests = stat.day_inactive = 0
      characters = Fundamental::Character.non_npc.where([ 'created_at <= ? AND created_at > ?', stat.created_at, stat.created_at - 1.days ])
      characters.each do |character|
        stat.day_num_registered         += 1   if character.max_conversion_state == "registered"
        stat.day_num_logged_in_once     += 1   if character.max_conversion_state == "logged_in_once"
        stat.day_num_ten_minutes        += 1   if character.max_conversion_state == "ten_minutes"
        stat.day_num_logged_in_two_days += 1   if character.max_conversion_state == "logged_in_two_days"
        stat.day_num_active             += 1   if character.max_conversion_state == "active"
        stat.day_num_long_term_active   += 1   if character.max_conversion_state == "long_term_active"
        stat.day_num_paying             += 1   if character.max_conversion_state == "paying"
        stat.day_credits_spent          += character.credits_spent_total || 0
        stat.day_gross                  += character.gross || 0.0
        stat.day_finished_quests        += character.num_finished_quests || 0
        stat.day_inactive               += 1   if character.last_login_at < Time.now - Backend::Stat.activity_period
      end   
         
      stat.save
    end
  end
 


  
  def self.gross_last_day
    Shop::MoneyTransaction.where(['created_at > ?', Time.now - 1.days]).sum(:gross)
  end
  
  def self.gross_last_week
    Shop::MoneyTransaction.where(['created_at > ?', Time.now - 1.weeks]).sum(:gross)
  end
  
  def self.gross_last_month
    Shop::MoneyTransaction.where(['created_at > ?', Time.now - 1.months]).sum(:gross)
  end 
  
  
  def self.credits_spent_last_day
    Shop::Transaction.closed.where(['created_at > ?', Time.now - 1.days]).sum(:credit_amount_booked)
  end
  
  def self.credits_spent_last_week
    Shop::Transaction.closed.where(['created_at > ?', Time.now - 1.weeks]).sum(:credit_amount_booked)
  end
  
  def self.credits_spent_last_month
    Shop::Transaction.closed.where(['created_at > ?', Time.now - 1.months]).sum(:credit_amount_booked)
  end  
  

  def self.num_new_users_last_day
    Fundamental::Character.where(['npc != ? AND created_at > ?', true, Time.now - 1.days]).count
  end

  def self.num_new_users_last_week
    Fundamental::Character.where(['npc != ? AND created_at > ?', true, Time.now - 1.weeks]).count
  end
  
  def self.num_new_users_last_month
    Fundamental::Character.where(['npc != ? AND created_at > ?', true, Time.now - 1.months]).count
  end  
  
  
  def self.playtime_new_users_last_day
    Fundamental::Character.where(['npc != ? AND created_at > ?', true, Time.now - 1.days]).sum(:playtime)
  end

  def self.playtime_new_users_last_week
    Fundamental::Character.where(['npc != ? AND created_at > ?', true, Time.now - 1.weeks]).sum(:playtime)
  end
  
  def self.playtime_new_users_last_month
    Fundamental::Character.where(['npc != ? AND created_at > ?', true, Time.now - 1.months]).sum(:playtime)
  end 
  
  
  
  def self.num_users_last_day
    Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.days]).count
  end

  def self.num_users_last_week
    Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.weeks]).count
  end
  
  def self.num_users_last_month
    Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.months]).count
  end  
    
  
  def self.num_lost_users_last_day
    Fundamental::Character.where(['npc != ? AND last_login_at > ? AND last_login_at < ?',
                                  true, 
                                  Time.now - Backend::Stat.activity_period - 1.days,        # logged in 1 day before activity period
                                  Time.now - Backend::Stat.activity_period]).count          # did not log in during activity period
  end

  def self.num_lost_users_last_week
    Fundamental::Character.where(['npc != ? AND last_login_at > ? AND last_login_at < ?',
                                  true, 
                                  Time.now - Backend::Stat.activity_period - 1.weeks,       # logged in 1 week before activity period
                                  Time.now - Backend::Stat.activity_period]).count          # did not log in during activity period
  end
  
  def self.num_lost_users_last_month
    Fundamental::Character.where(['npc != ? AND last_login_at > ? AND last_login_at < ?',
                                  true, 
                                  Time.now - Backend::Stat.activity_period - 1.months,      # logged in 1 month before activity period
                                  Time.now - Backend::Stat.activity_period]).count          # did not log in during activity period
  end

  
  
  
  def self.num_active_users
    Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - Backend::Stat.activity_period]).count
  end
  
  def self.num_paying_active_users
    Fundamental::Character.joins(:shop_transactions).where(['npc != ? AND last_login_at > ? AND state = ?', true, Time.now - Backend::Stat.activity_period, Shop::Transaction::STATE_CLOSED]).select('fundamental_characters.id').group('fundamental_characters.id').length  
  end
  
  def self.num_users
    Fundamental::Character.where(['npc != ?', true]).count
  end
  
  def self.num_paying_users
    Fundamental::Character.joins(:shop_transactions).where(['npc != ? AND state = ?', true, Shop::Transaction::STATE_CLOSED]).select('fundamental_characters.id').group('fundamental_characters.id').length  
  end  
  
  def self.resource_stats
    select_string = nil
    
    rules = GameRules::Rules.the_rules
    rules.resource_types.each do |resource_type| 
      select_string =  (select_string.blank? ? "" : (select_string + ", ")) + 
        "SUM(#{resource_type[:symbolic_id]}_amount) AS #{resource_type[:symbolic_id]}_amount_sum, " +
        "SUM(#{resource_type[:symbolic_id]}_production_rate) AS #{resource_type[:symbolic_id]}_production_rate_sum, " +
        "MAX(#{resource_type[:symbolic_id]}_amount) AS #{resource_type[:symbolic_id]}_amount_max, " +
        "MAX(#{resource_type[:symbolic_id]}_production_rate) AS #{resource_type[:symbolic_id]}_production_rate_max "
    end   
    
    r = Fundamental::ResourcePool.joins(:owner).where(['npc != ? AND last_login_at > ?', true, Time.now - Backend::Stat.activity_period]).select(select_string).first    
  end
  
  # month_num_registered
  # month_num_logged_in_once
  # month_num_logged_in_two_days
  # month_num_active
  # month_num_long_term_active
  # month_num_paying
  
  def month_num_paying_acc
    month_num_paying
  end
  
  def month_num_long_term_active_acc
    month_num_paying_acc + month_num_long_term_active
  end
  
  def month_num_active_acc
    month_num_long_term_active_acc + month_num_active
  end
  
  def month_num_logged_in_two_days_acc
    month_num_active_acc + month_num_logged_in_two_days
  end

  def month_num_ten_minutes_acc
    month_num_logged_in_two_days_acc + month_num_ten_minutes
  end 
  
  def month_num_logged_in_once_acc
    month_num_ten_minutes_acc + month_num_logged_in_once
  end  
  
  def month_num_registered_acc
    month_num_logged_in_once_acc + month_num_registered
  end

  def month_characters_total
    @month_characters_total ||= month_num_registered + month_num_logged_in_once + month_num_ten_minutes + month_num_logged_in_two_days + month_num_active + month_num_long_term_active + month_num_paying
  end
  
  
  
  def day_num_paying_acc
    day_num_paying
  end
  
  def day_num_long_term_active_acc
    day_num_paying_acc + day_num_long_term_active
  end
  
  def day_num_active_acc
    day_num_long_term_active_acc + day_num_active
  end
  
  def day_num_logged_in_two_days_acc
    day_num_active_acc + day_num_logged_in_two_days
  end

  def day_num_ten_minutes_acc
    day_num_logged_in_two_days_acc + day_num_ten_minutes
  end  
  
  def day_num_logged_in_once_acc
    day_num_ten_minutes_acc + day_num_logged_in_once
  end  
  
  def day_num_registered_acc
    day_num_logged_in_once_acc + day_num_registered
  end

  def day_characters_total
    @day_characters_total ||= day_num_registered + day_num_logged_in_once + day_num_ten_minutes + day_num_logged_in_two_days + day_num_active + day_num_long_term_active + day_num_paying
  end

  
  
  def recalc_all_stats
    self.dtimenew         = (Backend::Stat.playtime_new_users_last_day / 60.0).ceil
    self.wtimenew         = (Backend::Stat.playtime_new_users_last_week / 60.0).ceil
    self.mtimenew         = (Backend::Stat.playtime_new_users_last_month / 60.0).ceil

    self.dnu              = Backend::Stat.num_new_users_last_day
    self.wnu              = Backend::Stat.num_new_users_last_week
    self.mnu              = Backend::Stat.num_new_users_last_month
    
    self.du               = Backend::Stat.num_users_last_day
    self.wu               = Backend::Stat.num_users_last_week
    self.mu               = Backend::Stat.num_users_last_month
    
    self.dlu              = Backend::Stat.num_lost_users_last_day
    self.wlu              = Backend::Stat.num_lost_users_last_week
    self.mlu              = Backend::Stat.num_lost_users_last_month    

    self.dcs              = Backend::Stat.credits_spent_last_day
    self.wcs              = Backend::Stat.credits_spent_last_week
    self.mcs              = Backend::Stat.credits_spent_last_month   

    self.dgross           = Backend::Stat.gross_last_day
    self.wgross           = Backend::Stat.gross_last_week
    self.mgross           = Backend::Stat.gross_last_month   

    
    self.active_users     = Backend::Stat.num_active_users
    self.active_customers = Backend::Stat.num_paying_active_users

    self.total_users      = Backend::Stat.num_users
    self.total_customers  = Backend::Stat.num_paying_users

    resource_stats = Backend::Stat.resource_stats
    resource_stats.attributes.each do |k,v|
      self[k] = v
    end 
  end
  
end
