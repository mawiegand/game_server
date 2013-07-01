class Action::Fundamental::DisplayedPremiumExpirationActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?

    current_character.premium_expiration_displayed_at = DateTime.now
    current_character.save
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end