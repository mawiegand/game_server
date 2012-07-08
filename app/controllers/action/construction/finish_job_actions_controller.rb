class Action::Construction::FinishJobActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    logger.debug params.inspect
    Construction::Job.transaction do

      @construction_job = Construction::Job.lock.find(params[:action_construction_finish_job_actions][:job_id])
    
      raise ForbiddenError.new('not enough resources to pay for finishing job') unless current_character.resource_pool.have_at_least_resources({Fundamental::ResourcePool::RESOURCE_ID_CASH => 1})
    
      if @construction_job.active_job 
        queue = @construction_job.queue
        @construction_job.finish
        @construction_job.destroy
        current_character.resource_pool.remove_resources_transaction({Fundamental::ResourcePool::RESOURCE_ID_CASH => 1})
        queue.check_for_new_jobs
      else
        raise BadRequestError.new('no active job')
      end
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
