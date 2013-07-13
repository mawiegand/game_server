class Assignment::StandardAssignmentsController < ApplicationController
  layout 'assignment'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]


  # GET /assignment/standard_assignments
  # GET /assignment/standard_assignments.json
  def index
  
    last_modified = nil 

    if params.has_key?(:character_id)  
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Page Not Found')    if @character.nil?
      raise ForbiddenError.new('Access Forbidden') if !admin? && !staff? && !developer? && @character != current_character
      @assignment_standard_assignments = @character.standard_assignments
      # todo -> determine last_modified
    else 
      raise ForbiddenError.new('Access Forbidden') if !admin? && !staff? && !developer? 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @assignment_standard_assignments.nil?
            @assignment_standard_assignments =  Assignment::StandardAssignment.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')   if @asked_for_index     
          @assignment_standard_assignments = [] if @assignment_standard_assignments.nil?  # necessary? or ok to send 'null' ?
          render json: @assignment_standard_assignments
        end
      end
    end
  end

  # GET /assignment/standard_assignments/1
  # GET /assignment/standard_assignments/1.json
  def show
    @assignment_standard_assignment = Assignment::StandardAssignment.find_by_id(params[:id])
    raise NotFoundError.new('Not Found')         if @assignment_standard_assignment.nil?
    raise ForbiddenError.new('Access Forbidden') unless current_character ==  @assignment_standard_assignment.character || admin? || !staff? || !developer? 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment_standard_assignment }
    end
  end

  # GET /assignment/standard_assignments/new
  # GET /assignment/standard_assignments/new.json
  def new
    @assignment_standard_assignment = Assignment::StandardAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment_standard_assignment }
    end
  end

  # GET /assignment/standard_assignments/1/edit
  def edit
    @assignment_standard_assignment = Assignment::StandardAssignment.find(params[:id])
  end

  # POST /assignment/standard_assignments
  # POST /assignment/standard_assignments.json
  def create
    @assignment_standard_assignment = Assignment::StandardAssignment.new(params[:assignment_standard_assignment])

    respond_to do |format|
      if @assignment_standard_assignment.save
        format.html { redirect_to @assignment_standard_assignment, notice: 'Standard assignment was successfully created.' }
        format.json { render json: @assignment_standard_assignment, status: :created, location: @assignment_standard_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment_standard_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignment/standard_assignments/1
  # PUT /assignment/standard_assignments/1.json
  def update
    @assignment_standard_assignment = Assignment::StandardAssignment.find(params[:id])

    respond_to do |format|
      if @assignment_standard_assignment.update_attributes(params[:assignment_standard_assignment])
        format.html { redirect_to @assignment_standard_assignment, notice: 'Standard assignment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment_standard_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment/standard_assignments/1
  # DELETE /assignment/standard_assignments/1.json
  def destroy
    @assignment_standard_assignment = Assignment::StandardAssignment.find(params[:id])
    @assignment_standard_assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignment_standard_assignments_url }
      format.json { head :ok }
    end
  end
end
