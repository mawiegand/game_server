class Action::Assignment::RedeemStandardAssignmentRewardActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    @assignment = Assignment::StandardAssignment.find(params[:redeem_standard_assignment][:standard_assignment_id])
    raise NotFoundError.new('standard assignment not found') if @assignment.nil?
    raise ForbiddenError.new('not owner of standard assignment')  unless @assignment.character == current_character
    raise BadRequestError.new('standard assignment has not been started')   if !@assignment.ongoing?
    raise BadRequestError.new('standard assignment is not finished') unless @assignment.finished

    @assignment.redeem_rewards_deposit_and_end_transaction
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
