GameServer::Application.routes.draw do
  


  scope "/game_server" do
    scope "(:locale)", :locale => /en|de/ do   
      

      namespace :game_rules do
        resource :rules, :only => [ :show ]
      end

      namespace :ranking do 
        resources :character_rankings, :only => [ :index ]
      end


      namespace :backend do 
        resources :users 
      end

      namespace :effect do 
        resources :resource_effects 
      end

      namespace :fundamental do 
        
        match '/characters/self', :to => 'characters#self'
        
        resources :characters do
          resources :alliance_shouts
          resource  :account,         :module => "shop",      :only => [ :show ]
          resource  :resource_pool,                          :only => [ :show ] 
          resources :settlements,     :module => 'settlement'   
        end
        
        resources :resource_pools 
        
        resources :alliances do
          resources :characters
          resources :alliance_shouts
        end
        resources :alliance_shouts
        
        resources :guilds do
          resources :characters
        end
      end
      
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
      end
      resources :inboxes,  :path => "/fundamental/characters/:character_id/inboxes",  :module => 'messaging', :only => [:index]            
      resources :outboxes, :path => "/fundamental/characters/:character_id/outboxes", :module => 'messaging', :only => [:index]            
      resources :archives, :path => "/fundamental/characters/:character_id/archives", :module => 'messaging', :only => [:index]            



      namespace :settlement do 
        resources :settlements do 
          resources :slots 
          resources :histories
          # resources :queues, :module => 'construction'
        end
        resources :slots 
        resources :histories
      end

      resources :queues, :path => "/settlement/settlements/:settlement_id/construction_queues", :module => 'construction'            
      resources :queues, :path => "/settlement/settlements/:settlement_id/training_queues", :module => 'training'            
      
      resources :settlements, :path => "/map/locations/:location_id/settlements", :module => 'settlement'            


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
          resources :cancel_move_army_actions   
          resources :attack_army_actions       
        end 
        namespace :fundamental do
          resources :join_alliance_actions    
          resources :leave_alliance_actions    
          resources :create_alliance_actions    
        end
      end
      
      namespace :shop do
        resources :offers
        resources :resource_offers
        resources :bonus_offers
        resources :transactions
        resource :account, :only => [ :show ]
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
      
      resource :action, :only => [ :show ]
      
      resources :sessions, :module => :auth,    :only => [:new, :create, :destroy] # staff login to backend

      root :to => 'auth/sessions#new'             # redirect to signin
    
      match '/signin',  :to => 'auth/sessions#new'
      match '/signout', :to => 'auth/sessions#destroy'
    end    
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
