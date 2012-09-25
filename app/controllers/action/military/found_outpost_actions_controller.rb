class Action::Military::FoundOutpostActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate
  
  # Gives the "found outpost" command to the specified army,
  # if prerequisits (character as well as army are able to
  # found a city now) are met. We also require a location_id
  # to be send, also the army can only found outposts at its
  # present location. The redundant location_id is just to
  # make sure, the player really intended to found an 
  # outpost at the present position of the army --- due to 
  # lag, the player could be thinking the army is in a 
  # different place right now.
  #
  # POST /action/military/found_outpost_actions.json
  def create
    
    puts "HERE"
    
    raise BadRequestError.new('missing parameters')   unless params.has_key? :found_outpost_action
    
    settlement = nil
    
    ActiveRecord::Base.transaction do   # creating outposts is rather complex and dangerous stuff ;-) thus, wrap it in a transaction.

      current_character.lock!  # character needs to be locked for this task because it holds the settlement points...    
      army     = Military::Army.find(params[:found_outpost_action][:army_id],    :lock => true)
      location = Map::Location.find(params[:found_outpost_action][:location_id], :lock => true)
      
      army.details.lock!   unless army.details.nil?
    
      raise ForbiddenError.new('army is not at the location')                unless army.location_id == location.id 

      raise ForbiddenError.new('tried to give a command to a foreign army')  unless army.owner_id == current_character_id 

      raise ForbiddenError.new('army can not found outpost')                 unless army.can_found_outpost?
          
      raise ForbiddenError.new('character can not found outpost')            unless current_character.can_found_outpost?

      raise ForbiddenError.new('its not possible to found an outpost at that location') unless location.can_found_outpost_here?

      settlement = army.found_outpost!

    end

    raise InternaServerError.new('Founding the settlement failed for unkown reason. please inform support.') if settlement.nil?
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
