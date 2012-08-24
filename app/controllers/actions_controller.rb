class ActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate  
  
  def show
    
    create_army_action_parameters = 'action_military_create_army_action[location_id]'
    change_army_action_parameters = 'action_military_change_army_action[location_id], action_military_change_army_action[visible_army_id]'
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      create_army_action_parameters += ', action_military_create_army_action[' + unit_type[:db_field].to_s + ']'
      change_army_action_parameters += ', action_military_change_army_action[' + unit_type[:db_field].to_s + ']'
    end
    
    
    @all_actions = {
      Military: [
        { # CREATE ARMY
          url: action_military_create_army_actions_path,
          method: 'POST',
          name: 'Create Army',
          parameters: create_army_action_parameters,
        },
        { # CHANGE ARMY
          url: action_military_change_army_actions_path,
          method: 'POST',
          name: 'Change Army',
          parameters: change_army_action_parameters,
        },
        { # MOVE ARMY
          url: action_military_move_army_actions_path,
          method: 'POST',
          name: 'Move Army',
          parameters: 'action_military_move_army_action[army_id], action_military_move_army_action[target_location_id]',
        },
        { # CANCEL MOVE ARMY
          url: action_military_cancel_move_army_actions_path,
          method: 'POST',
          name: 'Cancel Move Army',
          parameters: 'action_military_cancel_move_army_action[army_id]',
        },
        { # ATTACK ARMY
          url: action_military_attack_army_actions_path,
          method: 'POST',
          name: 'Attack Army',
          parameters: 'action_military_attack_army_action[attacker_id], action_military_attack_army_action[defender_id]',
        },
        { # CHANGE ARMY NAME
          url: military_army_path(1),
          method: 'PUT',
          name: 'Change Army Name',
          parameters: 'military_army[name]',
        }
      ],
      Fundamental: [
        { # CREATE ALLIANCE
          url: action_fundamental_create_alliance_actions_path,
          method:     'POST',
          name:       'Create Alliance',
          parameters: 'alliance[tag], alliance[name]',
        },
        { # JOIN ALLIANCE
          url: action_fundamental_join_alliance_actions_path,
          method:     'POST',
          name:       'Join Alliance',
          parameters: 'alliance[tag], alliance[password]',
        },
        { # LEAVE ALLIANCE
          url: action_fundamental_leave_alliance_actions_path,
          method:     'POST',
          name:       'Leave Alliance',
          parameters: 'leave_alliance_action[alliance_id]',
        },
        { # CHANGE ALLIANCE PASSWORD
          url: fundamental_alliances_path,
          method:     'POST',
          name:       'Change Alliance Password',
          parameters: 'fundamental_alliances[password]',
        },
        { # SHOUT TO ALLIANCE
          url: fundamental_alliance_shouts_path,
          method:     'POST',
          name:       'Shout to Alliance',
          parameters: 'fundamental_alliance_shout[message]',
        },
      ],
      Construction: [
        { # NEW JOB
          url: construction_jobs_path,
          method: 'POST',
          name: 'Create Construction Job',
          parameters: 'construction_job[queue_id], construction_job[slot_id], construction_job[building_id], construction_job[level_before], construction_job[level_after], construction_job[job_type]' 
        },
      ],
      Training: [
        { # NEW JOB
          url: training_jobs_path,
          method: 'POST',
          name: 'Create Training Job',
          parameters: 'training_job[queue_id], training_job[quantity], training_job[unit_id]' 
        },
      ],
    }
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @all_actions.to_json   }#raise BadRequestError.new('Cannot be accessed using API.')}
    end
  end
  
end
