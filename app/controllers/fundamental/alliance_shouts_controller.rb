class Fundamental::AllianceShoutsController < ApplicationController
  # GET /fundamental/alliance_shouts
  # GET /fundamental/alliance_shouts.json
  def index
    @fundamental_alliance_shouts = Fundamental::AllianceShout.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_alliance_shouts }
    end
  end

  # GET /fundamental/alliance_shouts/1
  # GET /fundamental/alliance_shouts/1.json
  def show
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_alliance_shout }
    end
  end

  # GET /fundamental/alliance_shouts/new
  # GET /fundamental/alliance_shouts/new.json
  def new
    @fundamental_alliance_shout = Fundamental::AllianceShout.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_alliance_shout }
    end
  end

  # GET /fundamental/alliance_shouts/1/edit
  def edit
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])
  end

  # POST /fundamental/alliance_shouts
  # POST /fundamental/alliance_shouts.json
  def create
    @fundamental_alliance_shout = Fundamental::AllianceShout.new(params[:fundamental_alliance_shout])

    respond_to do |format|
      if @fundamental_alliance_shout.save
        format.html { redirect_to @fundamental_alliance_shout, notice: 'Alliance shout was successfully created.' }
        format.json { render json: @fundamental_alliance_shout, status: :created, location: @fundamental_alliance_shout }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_alliance_shout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/alliance_shouts/1
  # PUT /fundamental/alliance_shouts/1.json
  def update
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])

    respond_to do |format|
      if @fundamental_alliance_shout.update_attributes(params[:fundamental_alliance_shout])
        format.html { redirect_to @fundamental_alliance_shout, notice: 'Alliance shout was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_alliance_shout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/alliance_shouts/1
  # DELETE /fundamental/alliance_shouts/1.json
  def destroy
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])
    @fundamental_alliance_shout.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_alliance_shouts_url }
      format.json { head :ok }
    end
  end
end
