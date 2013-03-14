class Action::Messaging::ArchiveEntriesActionsController < ApplicationController

  before_filter :authenticate

  def create
  	raise BadRequestError.new('no current character')         if current_character.nil?
  	raise BadRequestError.new('missing parameter')            if params[:message_id].nil?
  	
    message = Messaging::Message.find_by_id(params[:message_id])
    
    raise ForbiddenError.new('no such message')               if message.nil?
  	raise ForbiddenError.new('user has no platinum account')  unless current_character.platinum_account?
    raise ForbiddenError.new('tried to move foreign message') unless message.recipient == current_character || message.sender == current_character

    message.move_to_archive_of_character(current_character)

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
  def get
  
  end
end
