require 'httparty'
require 'identity_provider/access'

class Fundamental::PersistentCharacterPropertiesController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate
  before_filter :deny_api
  
  def show
    @fundamental_character = Fundamental::Character.find(params[:id])

    ip_access = IdentityProvider::Access.new
    response = ip_access.get_start_bonus(@fundamental_character.identifier)
    
    @properties = wrapper.nil? ? nil : wrapper.data

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
end
