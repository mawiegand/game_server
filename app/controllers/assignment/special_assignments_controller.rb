class Assignment::SpecialAssignmentsController < ApplicationController
  layout 'assignment'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show]
  before_filter :authorize_staff, :except => [:show]

  # GET /assignment/special_assignments
  # GET /assignment/special_assignments.json
  def index
    @assignment_special_assignments = Assignment::SpecialAssignment.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignment_special_assignments }
    end
  end

  # GET /assignment/special_assignments/1
  # GET /assignment/special_assignments/1.json
  def show
    last_modified = nil

    if params.has_key?(:character_id)
      @character = Fundamental::Character.find_by_id(params[:character_id])
      raise NotFoundError.new('Page Not Found')               if @character.nil?
      #raise ForbiddenError.new('Access Forbidden')            if !admin? && !staff? && !developer? && @character != current_character
      @assignment_special_assignment = Assignment::SpecialAssignment.updated_special_assignment_of_character(@character)
      raise NotFoundError.new('Special Assignment Not Found') if @assignment_special_assignment.nil?
      # todo -> determine last_modified
    else
      @assignment_special_assignment = Assignment::SpecialAssignment.find_by_id(params[:id])
      raise NotFoundError.new('Special Assignment Not Found') if @assignment_special_assignment.nil?
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @assignment_special_assignment }
      end
    end
  end

  # GET /assignment/special_assignments/new
  # GET /assignment/special_assignments/new.json
  def new
    @assignment_special_assignment = Assignment::SpecialAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment_special_assignment }
    end
  end

  # GET /assignment/special_assignments/1/edit
  def edit
    @assignment_special_assignment = Assignment::SpecialAssignment.find(params[:id])
  end

  # POST /assignment/special_assignments
  # POST /assignment/special_assignments.json
  def create
    @assignment_special_assignment = Assignment::SpecialAssignment.new(params[:assignment_special_assignment])

    respond_to do |format|
      if @assignment_special_assignment.save
        format.html { redirect_to @assignment_special_assignment, notice: 'Special assignment was successfully created.' }
        format.json { render json: @assignment_special_assignment, status: :created, location: @assignment_special_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment_special_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignment/special_assignments/1
  # PUT /assignment/special_assignments/1.json
  def update
    @assignment_special_assignment = Assignment::SpecialAssignment.find(params[:id])

    respond_to do |format|
      if @assignment_special_assignment.update_attributes(params[:assignment_special_assignment])
        format.html { redirect_to @assignment_special_assignment, notice: 'Special assignment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment_special_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment/special_assignments/1
  # DELETE /assignment/special_assignments/1.json
  def destroy
    @assignment_special_assignment = Assignment::SpecialAssignment.find(params[:id])
    @assignment_special_assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignment_special_assignments_url }
      format.json { head :ok }
    end
  end
end
