class Assignment::SpecialAssignmentFrequenciesController < ApplicationController
  # GET /assignment/special_assignment_frequencies
  # GET /assignment/special_assignment_frequencies.json
  def index
    @assignment_special_assignment_frequencies = Assignment::SpecialAssignmentFrequency.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignment_special_assignment_frequencies }
    end
  end

  # GET /assignment/special_assignment_frequencies/1
  # GET /assignment/special_assignment_frequencies/1.json
  def show
    @assignment_special_assignment_frequency = Assignment::SpecialAssignmentFrequency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment_special_assignment_frequency }
    end
  end

  # GET /assignment/special_assignment_frequencies/new
  # GET /assignment/special_assignment_frequencies/new.json
  def new
    @assignment_special_assignment_frequency = Assignment::SpecialAssignmentFrequency.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment_special_assignment_frequency }
    end
  end

  # GET /assignment/special_assignment_frequencies/1/edit
  def edit
    @assignment_special_assignment_frequency = Assignment::SpecialAssignmentFrequency.find(params[:id])
  end

  # POST /assignment/special_assignment_frequencies
  # POST /assignment/special_assignment_frequencies.json
  def create
    @assignment_special_assignment_frequency = Assignment::SpecialAssignmentFrequency.new(params[:assignment_special_assignment_frequency])

    respond_to do |format|
      if @assignment_special_assignment_frequency.save
        format.html { redirect_to @assignment_special_assignment_frequency, notice: 'Special assignment frequency was successfully created.' }
        format.json { render json: @assignment_special_assignment_frequency, status: :created, location: @assignment_special_assignment_frequency }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment_special_assignment_frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignment/special_assignment_frequencies/1
  # PUT /assignment/special_assignment_frequencies/1.json
  def update
    @assignment_special_assignment_frequency = Assignment::SpecialAssignmentFrequency.find(params[:id])

    respond_to do |format|
      if @assignment_special_assignment_frequency.update_attributes(params[:assignment_special_assignment_frequency])
        format.html { redirect_to @assignment_special_assignment_frequency, notice: 'Special assignment frequency was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment_special_assignment_frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment/special_assignment_frequencies/1
  # DELETE /assignment/special_assignment_frequencies/1.json
  def destroy
    @assignment_special_assignment_frequency = Assignment::SpecialAssignmentFrequency.find(params[:id])
    @assignment_special_assignment_frequency.destroy

    respond_to do |format|
      format.html { redirect_to assignment_special_assignment_frequencies_url }
      format.json { head :ok }
    end
  end
end
