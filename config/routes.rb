GameServer::Application.routes.draw do



  scope "/game_server" do
    scope "(:locale)", :locale => /en|de/ do   
      
      namespace :game_rules do
        resource :rules, :only => [ :show ]
      end

      namespace :ranking do 
        resources :character_rankings, :only => [ :index ]
        resources :alliance_rankings,  :only => [ :index ]
        resources :fortress_rankings,  :only => [ :index ]
        resources :artifact_rankings,  :only => [ :index ]
        resource  :ranking_info,       :only => [ :show ]
        
        match '/character_rankings/self', :to => 'character_rankings#self'
      end
      
      
      namespace :assignment do 
        resources :special_assignment_frequencies 
        resources :special_assignments
        resources :standard_assignments       
      end


      namespace :backend do 
        resource  :dashboard, :controller => 'dashboard', :only => [:show, :create]
        resources :users 
        resources :partner_sites
        resources :stats
        resources :tutorial_stats
        resources :sign_in_log_entries
        resources :browser_stats
        resources :system_messages
        resources :trade_log_entries, :only => [ :index ]
        resources :user_content_reports
      end

      namespace :effect do 
        resources :alliance_construction_effects
        resources :construction_effects
        resources :alliance_resource_effects
        resources :resource_effects
      end

      namespace :fundamental do
        
        resource :round_info, :only => [:show, :edit, :update]
        resource :gossip,     :only => [:show]
        
        resources :persistent_character_properties
        
        match '/characters/self', :to => 'characters#self'
        
        resources :characters do
          resources :alliance_shouts
          resource  :account,         :module => "shop",       :only => [ :show ]
          resource  :resource_pool,                            :only => [ :show ]
          resource  :artifact,                                 :only => [ :show ]
          resource  :setting
          resources :history_events,                           :only => [ :index ]
        end

        resources :resource_pools

        resources :alliances do
          resources :characters
          resources :alliance_shouts
          resource  :alliance_reservation
          resources :victory_progresses
        end
        
        resources :victory_progresses 
        resources :victory_progress_leaders, :only => [ :index ]
        
        resources :alliance_shouts
        resources :alliance_reservations
        resources :artifacts
        resources :artifact_initiations


        resources :guilds do
          resources :characters
        end
        
        match '/announcements/recent', :to => 'announcements#recent'
        resources :announcements
        
        resources :settings
        
        resources :retention_mails
      end
      resources :settlements,     :path => "/fundamental/characters/:character_id/settlements",     :module => 'settlement', :only => [:index]            
      resource  :tutorial_state,  :path => "/fundamental/characters/:character_id/tutorial_state",  :module => 'tutorial',   :controller => 'states',   :only => [:show]
      resources :quests,          :path => "/fundamental/characters/:character_id/quests",          :module => 'tutorial',   :only => [:index]
      resources :purchases,       :path => "/fundamental/characters/:character_id/purchases",       :module => 'shop',       :controller => 'purchases',:only => [:index]
      resources :standard_assignments, :path => "/fundamental/characters/:character_id/standard_assignments",          :module => 'assignment',   :only => [:index]
      resource  :special_assignment,   :path => "/fundamental/characters/:character_id/special_assignment",            :module => 'assignment',   :only => [:show]

      resource  :shop_account,    :path => "/fundamental/characters/:character_id/shop_account",    :module => 'shop',       :controller => 'accounts', :only => [:show]

      resources :artifacts,       :path => "/map/regions/:region_id/artifacts",                     :module => 'fundamental'
      resources :artifacts,       :path => "/map/locations/:location_id/artifacts",                 :module => 'fundamental'

      resources :resource_effects, :path => "/fundamental/resource_pools/:resource_pool_id/resource_effects", :module => 'effect',   :only => [:index]
      resources :alliance_resource_effects, :path => "/fundamental/alliances/:alliance_id/alliance_resource_effects", :module => 'effect',   :only => [:index]
    
      resources :construction_effects, :path => "/fundamental/characters/:character_id/construction_effects", :module => 'effect',   :only => [:index]
      resources :alliance_construction_effects, :path => "/fundamental/alliances/:alliance_id/alliance_construction_effects", :module => 'effect',   :only => [:index]


      namespace :messaging do 
        resources :archives do
          resources :entries, :controller => :archive_entries
        end
        resources :outboxes do
          resources :entries, :controller => :outbox_entries
        end
        resources :inboxes do
          resources :entries, :controller => :inbox_entries 
        end
        resources :inbox_entries 
        resources :outbox_entries
        resources :archive_entries
        resources :messages
        resources :jabber_commands
      end
      resources :inboxes,  :path => "/fundamental/characters/:character_id/inboxes",  :module => 'messaging', :only => [:index]            
      resources :outboxes, :path => "/fundamental/characters/:character_id/outboxes", :module => 'messaging', :only => [:index]            
      resources :archives, :path => "/fundamental/characters/:character_id/archives", :module => 'messaging', :only => [:index]            



      namespace :settlement do 
        resources :settlements do 
          resources :slots 
          resources :histories
          resources :incoming_trading_carts,  :only => [ :index ]
          resources :outgoing_trading_carts,  :only => [ :index ]

          # resources :queues, :module => 'construction'
        end
        resources :slots 
        resources :histories
      end

      resources :queues, :path => "/settlement/settlements/:settlement_id/construction_queues", :module => 'construction'            
      resources :queues, :path => "/settlement/settlements/:settlement_id/training_queues", :module => 'training'            

      resources :settlements, :path => "/map/locations/:location_id/settlements", :module => 'settlement'            
      resources :settlements, :path => "/map/regions/:region_id/settlements", :module => 'settlement'            


      namespace :military do 
        resources :armies do
          resources :army_details
        end
        resources :army_details
        resources :battles do
          resources :battle_rounds 
          resources :battle_participants 
          resources :battle_factions
        end
        resources :battle_factions do
          resources :battle_participants 
        end
        resources :battle_participants 

        resources :battle_character_results
        resources :battle_participant_results 
        resources :battle_faction_results
        resources :battle_rounds
      end

      resources :armies, :path => "/map/regions/:region_id/armies", :module => 'military'            
      resources :armies, :path => "/map/locations/:location_id/armies", :module => 'military'            
      resources :armies, :path => "/fundamental/characters/:character_id/armies", :module => 'military'            
      resources :armies, :path => "/fundamental/alliances/:alliance_id/armies", :module => 'military'            

      resources :battles, :path => "/map/regions/:region_id/battles", :module => 'military'            
      resources :battles, :path => "/map/locations/:location_id/battles", :module => 'military'            

      namespace :map do 
        
        resources :nodes do 
          resources :regions 
        end
        resources :subtrees, :only => [ :show ]
        resource :area, :only => [ :show ]
        
        resources :regions do
          resources :locations
#         resources :armies, :module => 'military'             # doesn't work, since it looks for Map::Military::ArmiesController instead of Military::ArmiesController
#         resources :slots,  :controller => 'locations', :only => [ :show, :index ]  
        end
        resources :locations do
        end
        
        match 'regions/:region_id/slots',       :via => :get, :controller => 'locations', :action => 'index'
        match 'regions/:region_id/slots/:slot', :via => :get, :controller => 'locations', :action => 'show'
        match 'regions/:region_id/fortress',    :via => :get, :controller => 'locations', :action => 'show', :slot => 0
      end

      namespace :event do 
        resources :events
      end

      namespace :action do  
        namespace :military do 
          resources :move_army_actions          
          resources :create_army_actions         
          resources :change_army_actions         
          resources :reinforce_army_actions         
          resources :cancel_move_army_actions   
          resources :attack_army_actions       
          resources :retreat_army_actions      
          resources :found_outpost_actions, :only => [ :create ] 
        end 
        namespace :fundamental do
          resources :auto_join_alliance_actions,             :only => [ :create ]    
          resources :join_alliance_actions,                  :only => [ :create ]    
          resources :leave_alliance_actions    
          resources :create_alliance_actions    
          resources :kick_alliance_member_actions,           :only => [ :create ]
          resources :change_alliance_auto_join_setting_actions, :only => [ :create ]
          resources :change_alliance_description_actions,    :only => [ :create ]
          resources :change_character_description_actions,   :only => [ :create ]
          resources :send_alliance_application_actions,      :only => [ :create ]
          resources :change_avatar_actions,                  :only => [ :index, :create ]
          resources :change_character_notified_rank_actions, :only => [ :create ]    
          resources :change_character_name_actions,          :only => [ :create ]
          resources :change_character_same_ip_actions,       :only => [ :create ]
          resources :change_character_gender_actions,        :only => [ :create ]
          resources :change_character_password_actions,      :only => [ :create ]
          resources :track_character_conversions,            :only => [ :create ]
          resources :trade_resources_actions,                :only => [ :create ]
          resources :send_like_actions,                      :only => [ :create ]
          resources :send_dislike_actions,                   :only => [ :create ]
          resources :speedup_artifact_initiation_actions,    :only => [ :create ]
          resources :displayed_premium_expiration_actions,   :only => [ :create ]
          resources :user_content_report_actions,            :only => [ :create ]
        end
        namespace :construction do
          resources :finish_job_actions    
        end
        namespace :messaging do
          resources :archive_entries_actions#, :only => [ :create]
        end
        namespace :trading do 
          resources :trading_carts_actions 
          resources :speedup_trading_carts_actions,    :only => [ :create ]
        end 
        namespace :training do
          resources :speedup_job_actions    
        end
        namespace :assignment do
          resources :speedup_standard_assignment_actions, :only => [ :create ]
          resources :start_standard_assignment_actions, :only => [ :create ]
          resources :speedup_special_assignment_actions, :only => [ :create ]
          resources :start_special_assignment_actions, :only => [ :create ]
        end
        namespace :settlement do
          resources :change_tax_rate_actions, :only => [ :create ] 
          resources :abandon_outpost_actions, :only => [ :create ]
          resources :change_settlement_name_actions, :only => [ :create ]
          resources :redeem_slot_bubble_actions, :only => [ :create ]
          resources :move_settlement_to_region_actions, :only => [ :create ]
        end
        namespace :tutorial do
          resources :check_quest_actions,                 :only => [ :create ]    
          resources :mark_quest_displayed_actions,        :only => [ :create ]    
          resources :mark_quest_reward_displayed_actions, :only => [ :create ]    
          resources :redeem_rewards_actions,              :only => [ :create ]    
          resources :redeem_tutorial_end_rewards_actions, :only => [ :create ]    
        end
        namespace :shop do
          resources :redeem_purchase_actions,                :only => [ :create ]
          resources :special_offer_dialog_displayed_actions, :only =>[:create]
        end
        namespace :geo_treasure do
          resources :open_treasure_actions, :only =>[:create]
        end
      end
      
      namespace :treasure do 
        resources :treasures 
      end
      
      
      namespace :shop do
        resources :offers
        resources :purchases
        resources :resource_offers
        resources :bonus_offers
        resources :platinum_offers
        resources :special_offers
        resources :transactions
        resources :money_transactions
        resources :credit_transactions
        resources :special_offers_transactions
        resources :accounts, :only => [ :show ]
        resource :info, :controller => 'info', :only => [:show]
      end
      
      namespace :construction do
        resources :active_jobs
        resources :queues do
          resources :jobs
        end
        resources :jobs
      end
      
      namespace :training do
        resources :active_jobs
        resources :queues do
          resources :jobs
        end
        resources :jobs
      end
      
      namespace :tutorial do
        resource :tutorial 
        resources :states 
        resources :quests
      end

      namespace :like_system do
        resources :dislikes
        resources :likes
      end

      resource :action, :only => [ :show ]
      
      resources :sessions, :module => :auth,    :only => [:new, :create, :destroy] # staff login to backend

      root :to => 'auth/sessions#new'             # redirect to signin
    
      match '/signin',  :to => 'auth/sessions#new'
      match '/signout', :to => 'auth/sessions#destroy'
    end    
  end
end
