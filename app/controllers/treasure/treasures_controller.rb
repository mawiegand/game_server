class Treasure::TreasuresController < ApplicationController
  # GET /treasure/treasures
  # GET /treasure/treasures.json
  def index
    @treasure_treasures = Treasure::Treasure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @treasure_treasures }
    end
  end

  # GET /treasure/treasures/1
  # GET /treasure/treasures/1.json
  def show
    @treasure_treasure = Treasure::Treasure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @treasure_treasure }
    end
  end

  # GET /treasure/treasures/new
  # GET /treasure/treasures/new.json
  def new
    @treasure_treasure = Treasure::Treasure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @treasure_treasure }
    end
  end

  # GET /treasure/treasures/1/edit
  def edit
    @treasure_treasure = Treasure::Treasure.find(params[:id])
  end

  # POST /treasure/treasures
  # POST /treasure/treasures.json
  def create
    @treasure_treasure = Treasure::Treasure.new(params[:treasure_treasure])

    respond_to do |format|
      if @treasure_treasure.save
        format.html { redirect_to @treasure_treasure, notice: 'Treasure was successfully created.' }
        format.json { render json: @treasure_treasure, status: :created, location: @treasure_treasure }
      else
        format.html { render action: "new" }
        format.json { render json: @treasure_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /treasure/treasures/1
  # PUT /treasure/treasures/1.json
  def update
    @treasure_treasure = Treasure::Treasure.find(params[:id])

    respond_to do |format|
      if @treasure_treasure.update_attributes(params[:treasure_treasure])
        format.html { redirect_to @treasure_treasure, notice: 'Treasure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @treasure_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treasure/treasures/1
  # DELETE /treasure/treasures/1.json
  def destroy
    @treasure_treasure = Treasure::Treasure.find(params[:id])
    @treasure_treasure.destroy

    respond_to do |format|
      format.html { redirect_to treasure_treasures_url }
      format.json { head :ok }
    end
  end
end
