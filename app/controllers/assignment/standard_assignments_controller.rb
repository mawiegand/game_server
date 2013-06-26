class Assignment::StandardAssignmentsController < ApplicationController
  # GET /assignment/standard_assignments
  # GET /assignment/standard_assignments.json
  def index
    @assignment_standard_assignments = Assignment::StandardAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignment_standard_assignments }
    end
  end

  # GET /assignment/standard_assignments/1
  # GET /assignment/standard_assignments/1.json
  def show
    @assignment_standard_assignment = Assignment::StandardAssignment.find(params[:id])

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
