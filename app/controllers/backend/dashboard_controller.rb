class Backend::DashboardController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  before_filter :authorize_developer
  before_filter :deny_api
  
  def show
    @title = "Dashboard"
    @backend_user = current_backend_user
    
    @display_gross = admin? || staff?
    
    @user_groups = []
    
    @blocked_battle_events = []
    
    # calculate stats
    if staff? || developer?
      user_group = {}
      user_group[:user_stats] = {
        active_accounts:          Fundamental::Character.non_npc.platinum.count,
        deleted_accounts:         Fundamental::Character.non_npc.deleted.count,
        total_accounts:           Fundamental::Character.non_npc.count,
        signins_last_hour:        Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.hours]).count,
        signins_last_eight_hours: Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 8.hours]).count,
        signins_last_day:         Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.days]).count,
        signins_last_week:        Fundamental::Character.where(['npc != ? AND last_login_at > ?', true, Time.now - 1.weeks]).count,   
        
        presently_online:         Fundamental::Character.where(['npc != ? AND last_request_at > ?', true, Time.now - 2.minutes]).count, 
        online_last_hour:         Fundamental::Character.where(['npc != ? AND last_request_at > ?', true, Time.now - 1.hours]).count, 
      }
      
      user_group[:backend_stats]  = Backend::Stat.order('created_at ASC')
      
      user_group[:last_character] = Fundamental::Character.where('last_login_at IS NOT NULL').order('last_login_at DESC').first
      user_group[:last_character_signup] = Fundamental::Character.where('fundamental_characters.created_at IS NOT NULL').order('fundamental_characters.created_at DESC').first
      user_group[:new_characters] = Fundamental::Character.non_npc.not_deleted.paginate(:order => 'created_at DESC', :page => params[:page], :per_page => 25)
      
      @user_groups << user_group
    end

    # find blocked events
    if staff? || developer?
      battle_events = Event::Event.blocked.battle.executed_before(DateTime.now - 5.seconds)
      
      battle_events.each do |event|
        battle = Military::Battle.find_by_id(event.local_event_id)
        @blocked_battle_events << {
          event:  event,
          battle: battle
        }
      end
    end
    
    @world_stats = {
      day: Fundamental::RoundInfo.the_round_info.age,
      winner: Fundamental::RoundInfo.the_round_info.winner_alliance,
      victory: Fundamental::RoundInfo.the_round_info.victory_gained_at,
      empty_locations: Map::Location.empty.count,
      total_locations: Map::Location.count,
      non_occupied_regions: Map::Region.non_occupied.count,
      total_regions: Map::Region.count,
      battles: Military::Battle.ongoing.count,
    }
    
    @partner_sites = if @backend_user.admin? || @backend_user.staff?
      Backend::PartnerSite.order('sign_ups_count DESC') 
    elsif @backend_user.partner? 
      @backend_user.partner_sites.order('sign_ups_count DESC')
    else # developer or no role
      []
    end
    
  end
  
  def create 
  end
  
  protected
  
end
