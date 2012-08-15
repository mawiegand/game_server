class Tutorial::StatesController < ApplicationController
  # GET /tutorial/states
  # GET /tutorial/states.json
  def index
    @tutorial_states = Tutorial::State.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutorial_states }
    end
  end

  # GET /tutorial/states/1
  # GET /tutorial/states/1.json
  def show
    @tutorial_state = Tutorial::State.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutorial_state }
    end
  end

  # GET /tutorial/states/new
  # GET /tutorial/states/new.json
  def new
    @tutorial_state = Tutorial::State.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutorial_state }
    end
  end

  # GET /tutorial/states/1/edit
  def edit
    @tutorial_state = Tutorial::State.find(params[:id])
  end

  # POST /tutorial/states
  # POST /tutorial/states.json
  def create
    @tutorial_state = Tutorial::State.new(params[:tutorial_state])

    respond_to do |format|
      if @tutorial_state.save
        format.html { redirect_to @tutorial_state, notice: 'State was successfully created.' }
        format.json { render json: @tutorial_state, status: :created, location: @tutorial_state }
      else
        format.html { render action: "new" }
        format.json { render json: @tutorial_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutorial/states/1
  # PUT /tutorial/states/1.json
  def update
    @tutorial_state = Tutorial::State.find(params[:id])

    respond_to do |format|
      if @tutorial_state.update_attributes(params[:tutorial_state])
        format.html { redirect_to @tutorial_state, notice: 'State was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutorial_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutorial/states/1
  # DELETE /tutorial/states/1.json
  def destroy
    @tutorial_state = Tutorial::State.find(params[:id])
    @tutorial_state.destroy

    respond_to do |format|
      format.html { redirect_to tutorial_states_url }
      format.json { head :ok }
    end
  end
end
