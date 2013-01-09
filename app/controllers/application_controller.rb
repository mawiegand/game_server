require 'exception/http_exceptions'

class ApplicationController < ActionController::Base

  include ApplicationHelper
  include Auth::SessionsHelper

  before_filter :set_locale  # get the locale from the user parameters
  before_filter :setup_for_restkit
  around_filter :time_action

  rescue_from BearerAuthError, :with => :render_response_for_bearer_auth_exception
  rescue_from NotFoundError, BadRequestError, ForbiddenError, InternalServerError, ConflictError, NotImplementedError, ServiceUnavailableError, 
    :with => :render_response_for_exception

  # This method adds the locale to all rails-generated path, e.g. root_path.
  # Based on I18n documentation in rails guides:
  # http://guides.rubyonrails.org/i18n.html  
  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  protected
  
    # receives an array of fields and expands string-(wildcard)-fields in 
    # that array to matching attributes of the model. returns an array with
    # all symbol-elements from fields plus the attributes obtained by 
    # expanding the strings. A string-field matches an attribute in case
    # the attribute starts with this string (case-sensitive). For example
    # "unit_" matches attributes :unit_type, :unit_infantry, etc. .
    def self.expand_fields(m, fields) 
      result = []
      fields.each do | field |
        if field.is_a?(String)
          m.attributes.each do | attrib, value |
            result.push attrib if attrib.start_with? field
          end
        else
          result.push field
        end
      end
      result
    end
          
  

  
    def time_action
      started = Time.now
      yield
      elapsed = Time.now - started
      logger.debug("IF MODIFIED SINCE IN REQUEST HEADER: #{ request.env['HTTP_IF_MODIFIED_SINCE'] }.")
      logger.debug("Executing #{controller_name}::#{action_name} took #{elapsed*1000}ms in real-time.")
    end
    
    def setup_for_restkit 
      logger.debug "IN SETUP RESTKIT API, PRESENT BEHAVIOUR: include_root_in_json = #{ ActiveRecord::Base.include_root_in_json == true ? 'true' : 'false' }"
      
      if use_restkit_api?  
        ActiveRecord::Base.include_root_in_json = true 
        logger.debug "USE RESTKIT API FOR THIS REQUEST"
      else 
        ActiveRecord::Base.include_root_in_json = false 
        logger.debug "USE STANDARD API FOR THIS REQUEST"
      end
    end
    
    def use_restkit_api?
      !request.headers['X-RESTKIT-API'].blank?     
    end
    
    def include_root(hash, root) 
      use_restkit_api? ? { root => hash } : hash
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
      head :conflict if exception.class         == ConflictError
      head :unprocessable_entity if exception.class == UnprocessableEntityError
      head :unauthorized if exception.class     == UnauthorizedError
      
      # 5xx
      head :internal_server_error if exception.class     == InternalServerError
      head :not_implemented if exception.class     == NotImplementedError
      head :service_unavailable if exception.class     == ServiceUnavailableError
    end
    
    def render_html_for_exception(exception)
      render :text => exception.message, :status => :bad_request if exception.class == BadRequestError
      render :text => exception.message, :status => :not_found   if exception.class == NotFoundError
      render :text => exception.message, :status => :forbidden   if exception.class == ForbiddenError
      render :text => exception.message, :status => :conflict      if exception.class == ConflictError      
      render :text => exception.message, :status => :unprocessable_entity    if exception.class == UnprocessableEntityError      
      render :text => exception.message, :status => :unauthorized  if exception.class == UnauthorizedError      
      
      # 5xx
      render :text => exception.message, :status => :internal_server_error  if exception.class == InternalServerError      
      render :text => exception.message, :status => :not_implemented  if exception.class == NotImplementedError      
      render :text => exception.message, :status => :service_unavailable  if exception.class == ServiceUnavailableError      
    end


    # hanlde exceptions raised by a failed attempt to authorize with a bearer 
    # token of the resource and produce correct repsonses and headers. 
    def render_response_for_bearer_auth_exception(exception)
      info =   { :code => :bad_request }   # no description for unknwon (new or mislead) exception
      if exception.kind_of? BearerAuthInvalidRequest
        info = { :code => :bad_request,  :headers => { 'WWW-Authenticate' => 'Bearer realm="HeldenDuell", error="invalid_request", error_description ="'+exception.message+'"' } }
      elsif exception.kind_of?(BearerAuthInvalidToken) 
        info = { :code => :unauthorized, :headers => { 'WWW-Authenticate' => 'Bearer realm="HeldenDuell", error="invalid_token", error_description ="'+exception.message+'"' } }
      elsif exception.kind_of? BearerAuthInsufficientScope
        info = { :code => :forbidden,    :headers => { 'WWW-Authenticate' => 'Bearer realm="HeldenDuell", error="insufficient_scope", error_description ="'+exception.message+'"' } }
      elsif exception.instance_of?(BearerAuthError)
        info = { :code => :unauthorized, :headers => { 'WWW-Authenticate' => 'Bearer realm="HeldenDuell"' } }  # no error_code! (due to specs)
      end
      
      if info[:headers]
        info[:headers].each do |key, value|
          headers[key] = value
        end
      end

      logger.warn("%s: '%s', for request '%s' from %s" % [exception.class, exception.message, request.url, request.remote_ip] )

      respond_to do |format|
        format.html {
          render :text => exception.message, :status => info[:code]
        }
        format.json {
          head info[:code]
        }
      end
    end

end
