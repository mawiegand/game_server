module ApplicationHelper
  
  # This is a snippet from "Restful web services" to realize conditional get by a simple 
  # wrapper that can be used in every request. Needs RFC compliant if_modified_since.
  #
  #  curl -v -H "if_modified_since: Mon, 05 Mar 2012 23:58:08 GMT" localhost:3000/map/nodes/1.json
  def render_not_modified_or(last_modified)
    response.headers['Last-Modified'] = last_modified.httpdate if last_modified
    
    if_modified_since = request.env['HTTP_IF_MODIFIED_SINCE']
    
    if if_modified_since && last_modified && last_modified <= Time.httpdate(if_modified_since)  
      # has not changed
      render :nothing => true, :status => '304 Not Modified'
    else
      # has changed -> proceed with output processing
      yield
    end
  end
  
  

  def requested_json?
    return request.format == "application/json"
  end  

  def requested_html?
    return request.format == "text/html"
  end  
  
  def api_request?
    return requested_json?
  end
  
  def backend_request?
    return requested_html?
  end
  
  def deny_backend 
    deny_access if backend_request?
  end
  
  def deny_api
    deny_access if api_request?
  end
  
  # Checks whether the present visitor has authenticated himself properly
  # (that is, has successfully logged in using a valid identity) and
  # denies access otherwise.
  def authenticate
    return authenticate_backend if backend_request?
    return authenticate_api if api_request? 
    deny_access      # otherwise
  end
  
  def authenticate_backend
    deny_access unless signed_in_to_backend?
  end
  
  def authenticate_api
    deny_access unless signed_in?
  end
  
  # True, in case the present visitor has logged-in providing valid 
  # credentials of a registered identity. 
  def signed_in?
    !current_user.nil?
  end
  
  # Sets the current_identity to the given identity.
  def current_user=(user)
    @current_user = user
  end
  
  # Returns the current_identity in case the present visitor has logged-in. If
  # no identity has been set (e.g. because its the first call to this getter),
  # the method tries to get the identity from the rember token stored in the
  # visitor's cookie. If the remember token hasn't been set, the visitor hasn't
  # authenticated himself so far and thus, the method returns nil. 
  #
  # Thus, this method realizes the session tracking.
  def current_user
    raise BearerAuthInvalidRequest.new('Multiple access tokens sent within one request.') if !valid_authorization_header?
    @current_user ||= user_from_access_token 
  end
  
  def user_from_access_token
    raise BearerAuthInvalidRequest.new('Multiple access tokens sent within one request.') if !valid_authorization_header?
    return nil if request_access_token.nil?
    
    raise BearerAuthInvalidToken.new('Invalid or malformed access token.') unless request_access_token.valid? 
    raise BearerAuthInvalidToken.new('Access token expired.') if request_access_token.expired?
    raise BearerAuthInsufficientScope.new('Requested resource is not in authorized scope.') unless request_access_token.in_scope?('heldenduell')
  
    user = User.find_by_identifier(request_access_token.identifier)
  end
  
  def request_access_token
    return @request_access_token unless @request_access_token.nil?
    if request.headers['HTTP_AUTHORIZATION']
      chunks = request.headers['HTTP_AUTHORIZATION'].split(' ')
      raise BearerAuthInvalidRequest.new('Send bearer token in authorization header.') unless chunks.length == 2 && chunks[0].downcase == 'bearer'
      request_authorization[:method] = :header
      @request_access_token = FiveDAccessToken.new chunks[1]
    elsif params[:access_token]
      @request_access_token = FiveDAccessToken.new params[:access_token]
      if request.query_parameters[:access_token]
        request_authorization[:method] = :query   
      elsif request.request_parameters[:access_token]
        request_authorization[:method] = :request 
      else # e.g. extracted access_token from path
        raise BearerAuthInvalidRequest.new('Send access token in authorization header, query string or body (POST).')
      end
    else # no access token
      return nil
    end
    request_authorization[:grant_type] = :bearer
    request_authorization[:privileged] = false
    
    return @request_access_token
  end
  
  def request_authorization
    return @request_authorization ||= {}
  end
  
  # Method that should be called to block the user from accessing the 
  # requested page when he's not authorized to access it. The method
  # displays the given notice (using the flash) and redirects to the
  # sign-in form.
  def deny_access(notice = "You are not allowed to access this page. Please log in.")
    
    respond_to do |format|
      format.html {
          raise ForbiddenError.new "You have tried to access a resource you're not authorized to see. The incident has been logged."
      }
      format.json {
        if ! signed_in?
          raise BearerAuthError.new "Authorization needed."
        else
          raise ForbiddenError.new "You have tried to access a resource you're not authorized to see. The incident has been logged."
        end        
      }
    end
  end
  
  
  def valid_authorization_header?
    return @valid_authorization_header unless @valid_authorization_header.nil?
 
    logger.debug("debugger in app helper")

 
    num_access_tokens = 0
    num_access_tokens+=1 if request.query_parameters[:access_token]
    num_access_tokens+=1 if request.request_parameters[:access_token]
    num_access_tokens+=1 if request.path_parameters[:access_token]
    num_access_tokens+=1 if request.headers['HTTP_AUTHORIZATION']
    logger.debug("params: #{ params[:access_token] } header: #{ request.headers['HTTP_AUTHORIZATION'] } query string: #{ request.query_string} num tokens: #{num_access_tokens}")
    
    @valid_authorization_header = num_access_tokens <= 1 # received either one or no access token
  end
  
end
