require 'exception/http_exceptions'

class ApplicationController < ActionController::Base

  include ApplicationHelper

  before_filter :set_locale  # get the locale from the user parameters
  around_filter :time_action

  rescue_from NotFoundError, BadRequestError, ForbiddenError, :with => :render_response_for_exception

  # This method adds the locale to all rails-generated path, e.g. root_path.
  # Based on I18n documentation in rails guides:
  # http://guides.rubyonrails.org/i18n.html  
  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  protected
  
    # returns the currently logged-id character's id. This method does not
    # exectue a database request, it completely relies on the id sent with 
    # the authentication token. 
    # 
    # TODO: at present, always returns 5
    def current_character_id
      5 # from seeds: 5 -> Egbert
    end
    
    # returns the currently logged-id character. The character is determined 
    # with the help of the authentication token sent witht he request. This
    # method thus relies on current_character_id . If no authentication token
    # was sent with the request, this method returns nil.
    def current_character
      if current_character_id == 0
        return nil
      else 
        return Fundamental::Character.find(current_character_id)
      end
    end
  
    def time_action
      started = Time.now
      yield
      elapsed = Time.now - started
      logger.debug("Executing #{controller_name}::#{action_name} took #{elapsed*1000}ms in real-time.")
    end
  
    # Set the locale according to the user specified locale or to the default
    # locale, if not specified or specified is not available.
    def set_locale
      I18n.locale = get_locale_from_params || I18n.default_locale
    end
    
    # Checks whether the user specified locale is available.
    def get_locale_from_params 
      return nil unless params[:locale]
      I18n.available_locales.include?(params[:locale].to_sym) ? params[:locale] : nil
    end
    
    def render_response_for_exception(exception)  
      logger.warn("%s: '%s', for request '%s' from %s" % [exception.class, exception.message, request.url, request.remote_ip] )
      respond_to do |format|
        format.html {
          render_html_for_exception exception
        }
        format.json { 
          render_json_for_exception exception
        }
      end
    end
    
    def render_json_for_exception(exception)
      head :bad_request if exception.class  == BadRequestError
      head :not_found if exception.class    == NotFoundError 
      head :forbidden if exception.class    == ForbiddenError
    end
    
    def render_html_for_exception(exception)
      render :text => exception.message, :status => :bad_request if exception.class == BadRequestError
      render :text => exception.message, :status => :not_found   if exception.class == NotFoundError
      render :text => exception.message, :status => :forbidden   if exception.class == ForbiddenError
    end


end
