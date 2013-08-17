require 'geo_server/access'

class Action::GeoTreasure::OpenTreasureActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:open_treasure_action].nil? || params[:open_treasure_action][:tresure_id].blank?

    geo_server = GeoServer::Access.new({auth_token: request_access_token.token})

    if geo_server.open_treasure(params[:open_treasure_action][:tresure_id], current_character.identifier)

      # process treasure bonus

      respond_to do |format|
        format.json { render json: {}, status: :ok }
      end
    else
      raise ConflictError.new('could not open treasure')
    end
  end
end
