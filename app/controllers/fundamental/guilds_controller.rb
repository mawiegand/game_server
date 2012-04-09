class Fundamental::GuildsController < ApplicationController
  layout 'fundamental'
  
  # GET /fundamental/guilds
  # GET /fundamental/guilds.json
  def index
    @fundamental_guilds = Fundamental::Guild.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_guilds }
    end
  end

  # GET /fundamental/guilds/1
  # GET /fundamental/guilds/1.json
  def show
    @fundamental_guild = Fundamental::Guild.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_guild }
    end
  end

  # GET /fundamental/guilds/new
  # GET /fundamental/guilds/new.json
  def new
    @fundamental_guild = Fundamental::Guild.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_guild }
    end
  end

  # GET /fundamental/guilds/1/edit
  def edit
    @fundamental_guild = Fundamental::Guild.find(params[:id])
  end

  # POST /fundamental/guilds
  # POST /fundamental/guilds.json
  def create
    @fundamental_guild = Fundamental::Guild.new(params[:fundamental_guild])

    respond_to do |format|
      if @fundamental_guild.save
        format.html { redirect_to @fundamental_guild, notice: 'Guild was successfully created.' }
        format.json { render json: @fundamental_guild, status: :created, location: @fundamental_guild }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_guild.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/guilds/1
  # PUT /fundamental/guilds/1.json
  def update
    @fundamental_guild = Fundamental::Guild.find(params[:id])

    respond_to do |format|
      if @fundamental_guild.update_attributes(params[:fundamental_guild])
        format.html { redirect_to @fundamental_guild, notice: 'Guild was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_guild.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/guilds/1
  # DELETE /fundamental/guilds/1.json
  def destroy
    @fundamental_guild = Fundamental::Guild.find(params[:id])
    @fundamental_guild.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_guilds_url }
      format.json { head :ok }
    end
  end
end
