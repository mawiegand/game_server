class Action::Shop::GoogleRefreshAppCodeActionsController < ApplicationController
  layout 'action'

  def index
    code = params['code']

    if !code.nil? && !code.blank?
      config = Google::AppConfig.the_app_config
      config.code = code
      config.access_token = nil
      config.expires_at = nil
      notice = 'App Code successfully refreshed.' if config.save
    end

    respond_to do |format|
      format.html { redirect_to google_app_config_path, notice: notice }
      format.json { render json: {}, status: :ok }
    end
  end

end