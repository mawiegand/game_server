class ActionsController < ApplicationController
  layout 'action'
  
  def show
    @all_actions = {
      Military: [
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
        { # CHANGE ARMY NAME
          url: military_army_path(1),
          method: 'PUT',
          name: 'Change Army Name',
          parameters: 'military_army[name]',
        }
      ],
      Fundamental: [
        { # SHOUT TO ALLIANCE
          url: fundamental_alliance_shouts_path,
          method: 'POST',
          name: 'Shout to Alliance',
          parameters: 'fundamental_alliance_shout[message]',
        },
      ],
    }
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @all_actions.to_json   }#raise BadRequestError.new('Cannot be accessed using API.')}
    end
  end
  
end
