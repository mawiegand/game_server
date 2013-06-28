class Assignment::SpecialAssignmentsController < ApplicationController
  layout 'assignment'

 # before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /assignment/special_assignments
  # GET /assignment/special_assignments.json
  def index
    @assignment_special_assignments = Assignment::SpecialAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignment_special_assignments }
    end
  end

  # GET /assignment/special_assignments/1
  # GET /assignment/special_assignments/1.json
  def show
    @assignment_special_assignment = Assignment::SpecialAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment_special_assignment }
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
