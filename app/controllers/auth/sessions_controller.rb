# The SessionsController creates, tracks (by its helpers) and 
# and finally destroys a session for an authenticated user. 
#
class Auth::SessionsController < ApplicationController
    
  # Display a sign-in form
  def new
    @title = I18n.translate('sessions.signin.title')
  end
  
  # starts a session based on admin / staff credentials. 
  # Presently, credentials are hardcoded. Need to change 
  # that later. Should be connected to identity provider
  # in the future.
  def create
    
    if !params[:session] || params[:session][:login].blank? || params[:session][:password].blank? || 
       params[:session][:login] != "admin" || params[:session][:password] != "sonnen"
      logger.warn('BACK-END: login attempt with wrong user credentials for user #{params[:session][:login]}.')
      flash.now[:error] = I18n.translate('sessions.signin.flash.invalid')
      @title = I18n.translate('sessions.signin.title')
      render 'new'
    else 
      sign_in_to_backend(params[:session][:login])
      redirect_to users_url
    end
  end
  
  # Sings the user out by destroying the session.
  def destroy
    sign_out_with_backend
    redirect_to new_session_path
  end

end
