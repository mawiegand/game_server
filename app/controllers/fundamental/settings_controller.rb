class Fundamental::SettingsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /fundamental/settings
  # GET /fundamental/settings.json
  def index
    @fundamental_settings = Fundamental::Setting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_settings }
    end
  end

  # GET /fundamental/settings/1
  # GET /fundamental/settings/1.json
  def show
    @fundamental_setting = Fundamental::Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_setting }
    end
  end

  # GET /fundamental/settings/new
  # GET /fundamental/settings/new.json
  def new
    @fundamental_setting = Fundamental::Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_setting }
    end
  end

  # GET /fundamental/settings/1/edit
  def edit
    @fundamental_setting = Fundamental::Setting.find(params[:id])
  end

  # POST /fundamental/settings
  # POST /fundamental/settings.json
  def create
    @fundamental_setting = Fundamental::Setting.new(params[:fundamental_setting])

    respond_to do |format|
      if @fundamental_setting.save
        format.html { redirect_to @fundamental_setting, notice: 'Setting was successfully created.' }
        format.json { render json: @fundamental_setting, status: :created, location: @fundamental_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/settings/1
  # PUT /fundamental/settings/1.json
  def update
    @fundamental_setting = Fundamental::Setting.find(params[:id])

    respond_to do |format|
      if @fundamental_setting.update_attributes(params[:fundamental_setting])
        format.html { redirect_to @fundamental_setting, notice: 'Setting was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/settings/1
  # DELETE /fundamental/settings/1.json
  def destroy
    @fundamental_setting = Fundamental::Setting.find(params[:id])
    @fundamental_setting.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_settings_url }
      format.json { head :ok }
    end
  end
end
