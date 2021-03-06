class Tutorial::StatesController < ApplicationController
  layout 'tutorial'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:show]  
  before_filter :authorize_staff, :except => [:show]  

  # GET /tutorial/states
  # GET /tutorial/states.json
  def index
    @tutorial_states = Tutorial::State.all

    respond_to do |format|
      format.html do
        @tutorial_states = Tutorial::State.paginate(:page => params[:page], :per_page => 50)    
        @paginate = true   
      end
      format.json { render json: @tutorial_states }
    end
  end

  # GET /tutorial/states/1
  # GET /tutorial/states/1.json
  def show
    if params.has_key?(:character_id)  
      @tutorial_state = Tutorial::State.find_by_character_id(params[:character_id])
    else
      @tutorial_state = Tutorial::State.find_by_id(params[:id])
    end
    raise NotFoundError.new('Not Found.')        if @tutorial_state.nil?   
    raise ForbiddenError.new('Access Forbidden') if @tutorial_state.owner != current_character && !staff?  
    last_modified =  @tutorial_state.nil? ? nil : @tutorial_state.updated_at.utc
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html
        format.json do
          # \todo : REMOVE OLD API with nested quests
          render json:  use_restkit_api? ? @tutorial_state : @tutorial_state.to_json(:include => :quests) # old api directly includes quests.
        end
      end
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
