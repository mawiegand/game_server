class Fundamental::TreasuresController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /fundamental/treasures
  # GET /fundamental/treasures.json
  def index
    @fundamental_treasures = Fundamental::Treasure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_treasures }
    end
  end

  # GET /fundamental/treasures/1
  # GET /fundamental/treasures/1.json
  def show
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_treasure }
    end
  end

  # GET /fundamental/treasures/new
  # GET /fundamental/treasures/new.json
  def new
    @fundamental_treasure = Fundamental::Treasure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_treasure }
    end
  end

  # GET /fundamental/treasures/1/edit
  def edit
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])
  end

  # POST /fundamental/treasures
  # POST /fundamental/treasures.json
  def create
    @fundamental_treasure = Fundamental::Treasure.new(params[:fundamental_treasure])

    respond_to do |format|
      if @fundamental_treasure.save
        format.html { redirect_to @fundamental_treasure, notice: 'Treasure was successfully created.' }
        format.json { render json: @fundamental_treasure, status: :created, location: @fundamental_treasure }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/treasures/1
  # PUT /fundamental/treasures/1.json
  def update
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])

    respond_to do |format|
      if @fundamental_treasure.update_attributes(params[:fundamental_treasure])
        format.html { redirect_to @fundamental_treasure, notice: 'Treasure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/treasures/1
  # DELETE /fundamental/treasures/1.json
  def destroy
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])
    @fundamental_treasure.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_treasures_url }
      format.json { head :ok }
    end
  end
end
