class Action::Assignment::StartSpecialAssignmentActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    @values = params[:assignment_special_assignment]

    raise ForbiddenError.new('No current character')             if current_character.nil?
    @assignment = Assignment::SpecialAssignment.lock.find(params[:assignment_special_assignment][:special_assignment_id])

    raise ForbiddenError.new('not owner of assignment')          unless @assignment.character == current_character
    raise BadRequestError.new('assignment must not be started')  unless @assignment.started_at.nil?
    raise BadRequestError.new('assignment must not be ended')    unless @assignment.ended_at.nil?

    # assume the tavern is at home base (otherwise the settlement id must be send to controller to identifiy the settlement)
    requirement_groups = @assignment.assignment_type[:requirementGroups]
    requirements_met = requirement_groups.nil? || requirement_groups.empty? || GameState::Requirements.meet_one_requirement_group?(requirement_groups, current_character, current_character.home_location.settlement)
    raise BadRequestError.new('requirements not met')            unless requirements_met


    level = current_character.assignment_level || 0
    raise ForbiddenError.new('Character cannot solve assignments of this level')  if level < @assignment.assignment_type[:level]

    @assignment.pay_deposit_and_start_transaction
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
