class Backend::DashboardController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  # before_filter :authorize_staff
  before_filter :deny_api
  
  def show
    @title = "Dashboard"
    @backend_user = current_backend_user
    
    unless @backend_user.admin?
      @partner_site = Backend::PartnerSite.find(1)
      logger.debug current_backend_user.inspect
    else
      logger.debug Backend::PartnerSite.all.inspect
    end
    
    
    characters = @backend_user.admin? ? Fundamental::Character : @partner_site.characters 

    @user_stats = {
      active_accounts:          characters.non_npc.platinum.count,
      total_accounts:           characters.non_npc.count,
      signins_last_hour:        characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.hours]).count,
      signins_last_eight_hours: characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 8.hours]).count,
      signins_last_day:         characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.days]).count,
      signins_last_week:        characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.weeks]).count,   
      
      presently_online:         characters.where(['npc != ? AND last_request_at > ?', true, Time.now - 2.minutes]).count, 
      online_last_hour:         characters.where(['npc != ? AND last_request_at > ?', true, Time.now - 1.hours]).count, 
    }

    @backend_stats = Backend::Stat.order('created_at ASC') if @backend_user.admin?
    
    @last_character = characters.where('last_login_at IS NOT NULL').order('last_login_at DESC').first
    @last_character_signup = characters.where('fundamental_characters.created_at IS NOT NULL').order('fundamental_characters.created_at DESC').first
    
    @new_characters = characters.where(['npc != ? AND fundamental_characters.created_at IS NOT NULL AND fundamental_characters.created_at > ?', true, DateTime.now-1.days]).order('fundamental_characters.created_at DESC')
  end
  
  def create 
  end
  
  protected
  
end
