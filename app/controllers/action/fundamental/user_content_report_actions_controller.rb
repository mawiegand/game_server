class Action::Fundamental::UserContentReportActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:user_content_report_action].nil? || params[:user_content_report_action][:content_owner_id].blank? || params[:user_content_report_action][:content_type].blank? || params[:user_content_report_action][:content_id].blank?
    
    report = Backend::UserContentReport.new
		report.reporter_id = current_character.id
		report.content_owner_id = params[:user_content_report_action][:content_owner_id]
		report.content_type = params[:user_content_report_action][:content_type]
		report.content_id = params[:user_content_report_action][:content_id]

    raise BadRequestError.new('saving the user content report did fail.')  unless report.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
