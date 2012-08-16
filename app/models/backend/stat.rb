class Backend::Stat < ActiveRecord::Base
  
  before_create :recalc_all_stats
  
  def self.activity_period
    1.weeks
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
  
  
  def recalc_all_stats
    self.dnu          = Backend::Stat.num_new_users_last_day
    self.wnu          = Backend::Stat.num_new_users_last_week
    self.mnu          = Backend::Stat.num_new_users_last_month
    
    self.du           = Backend::Stat.num_users_last_day
    self.wu           = Backend::Stat.num_users_last_week
    self.mu           = Backend::Stat.num_users_last_month
    
    self.dlu          = Backend::Stat.num_lost_users_last_day
    self.wlu          = Backend::Stat.num_lost_users_last_week
    self.mlu          = Backend::Stat.num_lost_users_last_month    
    
    self.active_users     = Backend::Stat.num_active_users
    self.active_customers = Backend::Stat.num_paying_active_users

    self.total_users     = Backend::Stat.num_users
    self.total_customers = Backend::Stat.num_paying_users

    
  end
  
end
