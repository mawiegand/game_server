class Action::Shop::SpecialOfferDialogDisplayedActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no current character') if current_character.nil?

    if current_character.show_special_offers?
      current_character.special_offer_displayed_at = Time.now
      current_character.special_offer_dialog_count += 1
      current_character.save
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
