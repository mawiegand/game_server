class Action::Fundamental::UserContentReportActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise ForbiddenError.new('no current character')# if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:user_content_report_action].nil? || params[:user_content_report_action][:content_owner_id].blank? || params[:user_content_report_action][:content_type].blank? || params[:user_content_report_action][:content_id].blank?
    
    #alliance = current_character.alliance
    #alliance.description = params[:change_alliance_description_action][:description].strip
    #Backend::UserContentReport.create_alliance(params[:alliance][:tag], params[:alliance][:name], current_character)

    #raise BadRequestError.new('saving the alliance description did fails.')  unless alliance.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
