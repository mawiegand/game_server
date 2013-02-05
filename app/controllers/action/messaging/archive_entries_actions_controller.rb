class Action::Messaging::ArchiveEntriesActionsController < ApplicationController

  before_filter :authenticate

  def create
    
  	raise BadRequestError.new('no current character') if current_character.nil?
  	raise BadRequest.new('missing parameter') if params[:message_id].nil?
  	
    message = Messaging::Message.find_by_id(params[:message_id])
    
    raise ForbiddenError.new('no such message')                                          if message.nil?
  	raise ForbiddenError.new('tried to use premium-feature without permission')          unless current_character.platinum_account?    
    
    if message.recipient_id == current_character.id
      message.move_to_archive
    elsif message.sender_id == current_character.id
      message.move_to_archive
    else
      raise ForbiddenError.new('tried to move message of other user')
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
  def get
  
  end
end
