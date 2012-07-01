class Action::Construction::FinishJobActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    logger.debug params.inspect
    
    @construction_job = Construction::Job.find(params[:action_construction_finish_job_actions][:job_id])
    
    if @construction_job.active_job && current_character.resource_pool.have_at_least_resources({Fundamental::ResourcePool::RESOURCE_ID_CASH => 1})
      queue = @construction_job.queue
      @construction_job.finish
      @construction_job.destroy
      current_character.resource_pool.remove_resources_transaction({Fundamental::ResourcePool::RESOURCE_ID_CASH => 1})
      queue.check_for_new_jobs
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
