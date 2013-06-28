class Action::Training::SpeedupJobActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    @values = params[:assignment_standard_assignment]

    raise ForbiddenError.new "No current character"                              if current_character.nil?

    type_id = @values{:type_id} || -1
    assignment_type = GameRules::Rules.the_rules.assignment_types[type_id] || {}
    level = current_character.assignment_level || 0
    
    raise ForbiddenError.new "Character cannot solve assignments of this level"  if level < assignment_type[:level]
    
    @assignment = Assignment::StandardAssignment.create_if_not_existing(current_character, type)
    
    Assignment::StandardAssignment.transaction do
      
      raise ConflictError.new "There is already an ongoing assignment of this type"    if @assignment.ongoing?
      
      # todo remove costs and deposit
      
      @assignment.lock!
      @assignment.start_now
      @assignment.save!
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
