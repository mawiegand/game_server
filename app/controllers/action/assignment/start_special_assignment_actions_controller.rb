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

    level = current_character.assignment_level || 0
    raise ForbiddenError.new('Character cannot solve assignments of this level')  if level < @assignment.assignment_type[:level]

    @assignment.pay_deposit_and_start_transaction
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
