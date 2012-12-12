class Backend::DashboardController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  # before_filter :authorize_staff
  before_filter :deny_api
  
  def show
    @title = "Dashboard"
    @backend_user = current_backend_user
    
    @user_groups = []
    
    if @backend_user.admin?
      user_group = {}
      user_group[:header] = "All Users"
      user_group[:user_stats] = {
        active_accounts:          Fundamental::Character.non_npc.platinum.count,
        total_accounts:           Fundamental::Character.non_npc.count,
        signins_last_hour:        Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.hours]).count,
        signins_last_eight_hours: Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 8.hours]).count,
        signins_last_day:         Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.days]).count,
        signins_last_week:        Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.weeks]).count,   
        
        presently_online:         Fundamental::Character.where(['npc != ? AND last_request_at > ?', true, Time.now - 2.minutes]).count, 
        online_last_hour:         Fundamental::Character.where(['npc != ? AND last_request_at > ?', true, Time.now - 1.hours]).count, 
      }
      
      user_group[:backend_stats] = Backend::Stat.order('created_at ASC')
      
      user_group[:last_character] = Fundamental::Character.where('last_login_at IS NOT NULL').order('last_login_at DESC').first
      user_group[:last_character_signup] = Fundamental::Character.where('fundamental_characters.created_at IS NOT NULL').order('fundamental_characters.created_at DESC').first
      user_group[:new_characters] = Fundamental::Character.where(['npc != ? AND fundamental_characters.created_at IS NOT NULL AND fundamental_characters.created_at > ?', true, DateTime.now-1.days]).order('fundamental_characters.created_at DESC')
      
      @user_groups << user_group
    end
    
    partner_sites = !@backend_user.admin? && !@backend_user.staff? && @backend_user.partner? ? @backend_user.partner_sites : Backend::PartnerSite.all
    
    partner_sites.each do |site|
      user_group = {}
      user_group[:header] = "#{site.description} (#{site.referer}" + (site.r.empty? ? ")" : ", r=#{site.r})") 
      user_group[:user_stats] = {
        active_accounts:          site.characters.non_npc.platinum.count,
        total_accounts:           site.characters.non_npc.count,
        signins_last_hour:        site.characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.hours]).count,
        signins_last_eight_hours: site.characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 8.hours]).count,
        signins_last_day:         site.characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.days]).count,
        signins_last_week:        site.characters.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.weeks]).count,   
        
        presently_online:         site.characters.where(['npc != ? AND last_request_at > ?', true, Time.now - 2.minutes]).count, 
        online_last_hour:         site.characters.where(['npc != ? AND last_request_at > ?', true, Time.now - 1.hours]).count, 
      }
      
      user_group[:last_character] = site.characters.where('last_login_at IS NOT NULL').order('last_login_at DESC').first
      user_group[:last_character_signup] = site.characters.where('fundamental_characters.created_at IS NOT NULL').order('fundamental_characters.created_at DESC').first
      user_group[:new_characters] = site.characters.where(['npc != ? AND fundamental_characters.created_at IS NOT NULL AND fundamental_characters.created_at > ?', true, DateTime.now-1.days]).order('fundamental_characters.created_at DESC')
      
      @user_groups << user_group
    end
  end
  
  def create 
  end
  
  protected
  
end
