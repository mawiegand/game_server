class Action::Shop::GoogleRefreshAppCodeActionsController < ApplicationController
  layout 'action'

  def index
    code = params['code']

    if code.present?
      notice = 'App Code successfully refreshed.' if Google::AppConfig.set_app_code code
    end

    respond_to do |format|
      format.html { redirect_to google_app_config_path(show_notice: true), notice: notice }
      format.json { render json: {}, status: :ok }
    end
  end

end