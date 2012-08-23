class Action::Training::SpeedupJobActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # TODO:   THIS DOES NOT CHECK THE OWNERSHIP OF THE JOB!!!
  def create
    logger.debug params.inspect
    Training::Job.transaction do

      @training_job = Training::Job.lock.find(params[:action_training_speedup_job_actions][:job_id])
      raise BadRequestError.new('no active job')   if @training_job.active_job.nil?
      
      speedup_costs = GameRules::Rules.the_rules.training_speedup
      entry = nil
      
      speedup_costs.each do |item|
        entry = item    if entry.nil? && @speedup_costs.active_job.finished_at < Time.now + item[:hours].hours
      end

      raise BadRequestError.new('job cannot be speedup; it takes to long.')  if entry.nil?

      price = { entry[:resource_id] => entry[:amount] }

      raise ForbiddenError.new('not enough resources to pay for finishing job') unless current_character.resource_pool.have_at_least_resources(price)
    
      queue = @training_job.queue
      #@construction_job.finish
      #@construction_job.destroy
      current_character.resource_pool.remove_resources_transaction(price)
      #queue.check_for_new_jobs
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
