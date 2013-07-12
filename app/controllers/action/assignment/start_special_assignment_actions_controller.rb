class Action::Assignment::StartSpecialAssignmentActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    @values = params[:assignment_special_assignment]

    raise ForbiddenError.new "No current character"                                  if current_character.nil?

    type_id = @values[:type_id].to_i || -1
    assignment_type = GameRules::Rules.the_rules.assignment_types[type_id] || {}
    level = current_character.assignment_level || 0
    
    raise ForbiddenError.new "Character cannot solve assignments of this level"  if level < assignment_type[:level]
    
    @assignment = Assignment::StandardAssignment.create_if_not_existing(current_character, assignment_type)
    
    raise ConflictError.new "There is already an ongoing assignment of this type"    if @assignment.ongoing?
    
    @assignment.pay_deposit_and_start_transaction
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
