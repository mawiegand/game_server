class Action::Fundamental::SpeedupArtifactInitiationActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    Fundamental::Artifact.transaction do

      @artifact = Fundamental::Artifact.lock.find(params[:action_fundamental_speedup_artifact_initiation][:artifact_id])
      raise ForbiddenError.new('not owner of artifact') unless @artifact.owner == current_character
      raise BadRequestError.new('no initiation found')  if @artifact.initiation.nil?
      raise BadRequestError.new('initiation already hurried') if @artifact.initiation.hurried?

      entry = nil
      GameRules::Rules.the_rules.artifact_initiation_speedup.each do |item|
        entry = item if entry.nil? && @artifact.initiation.finished_at < Time.now + item[:hours].hours
      end

      raise BadRequestError.new('artifact initiation cannot be speedup; it takes to long.')  if entry.nil?

      price = {
        entry[:resource_id] => entry[:amount]
      }

      unless current_character.resource_pool.have_at_least_resources(price)
        raise ForbiddenError.new('not enough resources to pay for finishing job')
      end
    
      @artifact.initiation.speedup
      current_character.resource_pool.remove_resources_transaction(price)
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
