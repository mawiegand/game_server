class Action::Fundamental::JoinAllianceActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('tried to join an alliance although character is already in an alliance') unless current_character.alliance.nil?
    raise UnauthorizedError.new('no alliance password given') if params[:alliance][:password].nil?
    raise ForbiddenError.new('joining new alliance not allowed') if !current_character.can_join_alliance?


    alliance = Fundamental::Alliance.find_by_tag(params[:alliance][:tag])

    if alliance.nil?
      alliance_reservation = Fundamental::AllianceReservation.find_by_tag(params[:alliance][:tag])
      raise NotFoundError.new('alliance with given tag not found') if alliance_reservation.nil?
      raise ForbiddenError.new('wrong alliance reservation password') unless alliance_reservation.password == params[:alliance][:password]
      # create alliance, current character will be added automatically
      alliance_reservation.alliance = Fundamental::Alliance.create_alliance(alliance_reservation.tag, alliance_reservation.name, current_character)
      alliance_reservation.save
    else
      raise ForbiddenError.new('wrong alliance password') unless alliance.password == params[:alliance][:password]
      raise ConflictError.new("too many members in alliance") if alliance.full?
      alliance.add_character(current_character)
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
