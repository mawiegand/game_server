class Backend::DashboardController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  before_filter :authorize_staff
  before_filter :deny_api
  
  def show
    @title = "Dashboard"

    @backend_user = current_backend_user

    @user_stats = {
      active_accounts:          Fundamental::Character.where(['npc != ? AND premium_account = ?', true, true]).count,
      total_accounts:           Fundamental::Character.where(['npc != ?', true]).count,
      signins_last_hour:        Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.hours]).count,
      signins_last_eight_hours: Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 8.hours]).count,
      signins_last_day:         Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.days]).count,
      signins_last_week:        Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.weeks]).count,      
    }
    
    @last_character = Fundamental::Character.unscoped.where('last_login_at IS NOT NULL').order('last_login_at DESC').first

  end
  
  def create 
  end
  
  protected
  
end
