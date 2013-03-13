class Fundamental::VictoryProgressesController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /fundamental/victory_progresses
  # GET /fundamental/victory_progresses.json
  def index
    if params.has_key?(:alliance_id)
      alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Alliance Not Found')       if alliance.nil?
      #raise ForbiddenError.new('Not member of alliance')  unless alliance == current_character.alliance
      @fundamental_victory_progresses = alliance.victory_progresses
    else
      raise ForbiddenError.new('Acess denied.') unless staff?
      @fundamental_victory_progresses = Fundamental::VictoryProgress.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_victory_progresses }
    end
  end

  # GET /fundamental/victory_progresses/1
  # GET /fundamental/victory_progresses/1.json
  def show
    @fundamental_victory_progress = Fundamental::VictoryProgress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_victory_progress }
    end
  end

  # GET /fundamental/victory_progresses/new
  # GET /fundamental/victory_progresses/new.json
  def new
    @fundamental_victory_progress = Fundamental::VictoryProgress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_victory_progress }
    end
  end

  # GET /fundamental/victory_progresses/1/edit
  def edit
    @fundamental_victory_progress = Fundamental::VictoryProgress.find(params[:id])
  end

  # POST /fundamental/victory_progresses
  # POST /fundamental/victory_progresses.json
  def create
    @fundamental_victory_progress = Fundamental::VictoryProgress.new(params[:fundamental_victory_progress])

    respond_to do |format|
      if @fundamental_victory_progress.save
        format.html { redirect_to @fundamental_victory_progress, notice: 'Victory progress was successfully created.' }
        format.json { render json: @fundamental_victory_progress, status: :created, location: @fundamental_victory_progress }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_victory_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/victory_progresses/1
  # PUT /fundamental/victory_progresses/1.json
  def update
    @fundamental_victory_progress = Fundamental::VictoryProgress.find(params[:id])

    respond_to do |format|
      if @fundamental_victory_progress.update_attributes(params[:fundamental_victory_progress])
        format.html { redirect_to @fundamental_victory_progress, notice: 'Victory progress was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_victory_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/victory_progresses/1
  # DELETE /fundamental/victory_progresses/1.json
  def destroy
    @fundamental_victory_progress = Fundamental::VictoryProgress.find(params[:id])
    @fundamental_victory_progress.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_victory_progresses_url }
      format.json { head :ok }
    end
  end
end
