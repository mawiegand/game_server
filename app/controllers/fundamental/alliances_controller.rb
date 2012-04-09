class Fundamental::AlliancesController < ApplicationController
  layout 'fundamental'
  
  # GET /fundamental/alliances
  # GET /fundamental/alliances.json
  def index
    @fundamental_alliances = Fundamental::Alliance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_alliances }
    end
  end

  # GET /fundamental/alliances/1
  # GET /fundamental/alliances/1.json
  def show
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_alliance }
    end
  end

  # GET /fundamental/alliances/new
  # GET /fundamental/alliances/new.json
  def new
    @fundamental_alliance = Fundamental::Alliance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_alliance }
    end
  end

  # GET /fundamental/alliances/1/edit
  def edit
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])
  end

  # POST /fundamental/alliances
  # POST /fundamental/alliances.json
  def create
    @fundamental_alliance = Fundamental::Alliance.new(params[:fundamental_alliance])

    respond_to do |format|
      if @fundamental_alliance.save
        format.html { redirect_to @fundamental_alliance, notice: 'Alliance was successfully created.' }
        format.json { render json: @fundamental_alliance, status: :created, location: @fundamental_alliance }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/alliances/1
  # PUT /fundamental/alliances/1.json
  def update
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])

    respond_to do |format|
      if @fundamental_alliance.update_attributes(params[:fundamental_alliance])
        format.html { redirect_to @fundamental_alliance, notice: 'Alliance was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/alliances/1
  # DELETE /fundamental/alliances/1.json
  def destroy
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])
    @fundamental_alliance.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_alliances_url }
      format.json { head :ok }
    end
  end
end
