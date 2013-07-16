class Action::Assignment::SpeedupSpecialAssignmentActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    Assignment::SpecialAssignment.transaction do

      @assignment = Assignment::SpecialAssignment.lock.find(params[:speedup_special_assignment][:special_assignment_id])

      raise ForbiddenError.new('not owner of assignment')  unless @assignment.character == current_character
      raise BadRequestError.new('assignment not active')   if @assignment.ended_at.nil?
      raise BadRequestError.new('already hurried job')     if @assignment.hurried?
      
      speedup_costs    = 2
      speedup_resource = 3
      
      price = { speedup_resource => speedup_costs }

      raise ForbiddenError.new('not enough resources to pay for finishing job') unless current_character.resource_pool.have_at_least_resources(price)
    
      @assignment.speedup_now
      @assignment.save!
      current_character.resource_pool.remove_resources_transaction(price)
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
