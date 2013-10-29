class Facebook::AppConfigsController < ApplicationController
  layout 'facebook'

  # GET /facebook/app_configs/1
  # GET /facebook/app_configs/1.json
  def show
    @facebook_app_config = Facebook::AppConfig.find(1)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facebook_app_config }
    end
  end

  # GET /facebook/app_configs/1/edit
  def edit
    @facebook_app_config = Facebook::AppConfig.find(1)
  end

  # PUT /facebook/app_configs/1
  # PUT /facebook/app_configs/1.json
  def update
    @facebook_app_config = Facebook::AppConfig.find(1)

    respond_to do |format|
      if @facebook_app_config.update_attributes(params[:facebook_app_config])
        format.html { redirect_to @facebook_app_config, notice: 'App config was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @facebook_app_config.errors, status: :unprocessable_entity }
      end
    end
  end
end
