class Google::AppConfigsController < ApplicationController
  layout 'google'

  before_filter :deny_api
  before_filter :authenticate
  before_filter :authorize_staff

  # GET /google/app_configs/1
  # GET /google/app_configs/1.json
  def show
    if params.has_key? :fetch_auth_tokens
      if Google::AppConfig.fetch_auth_tokens
        flash[:notice] = 'Auth tokens successfully refreshed.'
      else
        flash[:notice] = 'Could not refresh auth tokens. Try to refresh the app code.'
      end
    elsif params.has_key? :refresh_access_token
      if Google::AppConfig.refresh_access_token
        flash[:notice] = 'Access token successfully refreshed.'
      else
        flash[:notice] = 'Could not refresh access token. Try to refresh the app code and refresh token.'
      end
    elsif !params.has_key? :show_notice
      flash.delete(:notice)
    end

    @google_app_config = Google::AppConfig.the_app_config

    respond_to do |format|
      format.html
    end
  end

  # GET /google/app_configs/1/edit
  def edit
    @google_app_config = Google::AppConfig.the_app_config
  end

  # PUT /google/app_configs/1
  # PUT /google/app_configs/1.json
  def update
    @google_app_config = Google::AppConfig.the_app_config

    respond_to do |format|
      if @google_app_config.update_attributes(params[:google_app_config])
        format.html { redirect_to @google_app_config, notice: 'App config was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
