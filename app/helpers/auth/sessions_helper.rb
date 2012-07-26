require 'five_d/access_token'
module Auth
  
  # Contains helpers for establishing and tracking a BACKEND session as well
  # as all authoritzation stuff for both, backend users (staff, admins) and
  # players (characters, authentication provided by identity-provider). 
  #
  # The overal logic is as follows:
  # A) determine whether it's a backend (HTML) or client (JSON) request.
  # B) make sure to authentheldeicate backend requests only with session token 
  #    (cookie), and to authenticate client requests only by bearer
  #    token (provided by identity_provider). 
  # C) given the authenticated backend / client user, authorize requests 
  #    seperately for the request types (client may access different 
  #    resources than backend user and vice versa)
  # D) make sure that 
  #    - it's not possible for clients to get a session token (cookie) with 
  #      the help of bearer token (trade one auth for the other)
  #    - it's not possible to authenticate with both, bearer token and cookie
  #    - it's not possible to access backend-functionality with bearer token 
  #      authentication
  # The implementation distinguishes between client and backend users and has
  # seperate (doubled) methods (current_user/character, authentication & 
  # authorization filters) for both. This complexity unfortunately is 
  # necessary in order to achieve D.
  module SessionsHelper
    
    # Roles (access authorization)  
  
    # returns the highest possible role of the current backend user / current
    # character concerning access to a specific resource. Caller has to provide
    # the resource owner's id and its belonging alliance id, which are stored
    # usually together with the resource. If the resource does not have a 
    # specific owner or owning alliance, pass in nil instead of the id. 
    # 
    # Presently, this method assumes there has been set a current_character 
    # if signed_in? is true. 
    #
    # The returned role is one of (from highest access to lowest):
    #  - admin
    #  - staff
    #  - owner
    #  - ally
    #  - default
    def determine_access_role(resource_owner_id, resource_alliance_id)
      if signed_in?     # make this decision early in order to prevent unnecessary access to backend_users table
        return :owner     if !resource_owner_id.nil?    && resource_owner_id    == current_character.id 
        return :ally      if !resource_alliance_id.nil? && resource_alliance_id == current_character.alliance_id
      else
        return :admin     if admin?
        return :staff     if staff?
      end
      return :default
    end
    
    
    # Authentication and Protocol Authorization

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
      !current_character.nil?
    end
    
    # Sets the current_identity to the given identity.
    def current_character=(character)
      @current_character = character
    end

  
    # Returns the current_identity in case the present visitor has logged-in. If
    # no identity has been set (e.g. because its the first call to this getter),
    # the method tries to get the identity from the rember token stored in the
    # visitor's cookie. If the remember token hasn't been set, the visitor hasn't
    # authenticated himself so far and thus, the method returns nil. 
    #
    # Thus, this method realizes the session tracking.
    def current_character
      raise BearerAuthInvalidRequest.new('Multiple access tokens sent within one request.') if !valid_authorization_header?
      @current_character ||= character_from_access_token 
    end
  
    def current_character_id
      current_character.id
    end
  
    def character_from_access_token
      raise BearerAuthInvalidRequest.new('Multiple access tokens sent within one request.') if !valid_authorization_header?
      return nil if request_access_token.nil?
    
      raise BearerAuthInvalidToken.new('Invalid or malformed access token.') unless request_access_token.valid? 
      raise BearerAuthInvalidToken.new('Access token expired.') if request_access_token.expired?
      raise BearerAuthInsufficientScope.new('Requested resource is not in authorized scope.') unless request_access_token.in_scope?(GAME_SERVER_CONFIG['scope'])
  
      character = Fundamental::Character.find_by_identifier(request_access_token.identifier)
    end
  
    def request_access_token
      return @request_access_token unless @request_access_token.nil?
      if request.headers['HTTP_AUTHORIZATION']
        chunks = request.headers['HTTP_AUTHORIZATION'].split(' ')
        raise BearerAuthInvalidRequest.new('Send bearer token in authorization header.') unless chunks.length == 2 && chunks[0].downcase == 'bearer'
        request_authorization[:method] = :header
        @request_access_token = FiveD::AccessToken.new chunks[1]
      elsif params[:access_token]
        @request_access_token = FiveD::AccessToken.new params[:access_token]
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

    def admin?
      backend_admin?
    end
    
    def staff?
      backend_staff?
    end
  
    # Checks whether the present user has admin-status and redirects to 
    # sign-in otherwise.
    def authorize_admin
      deny_access I18n.translate('sessions.authorization.access_denied.admin') unless admin?
    end
  
    # Checks whether the present user has staff-status and redirects to
    # sign-in otherwise. Admin users always have staff-status.
    def authorize_staff
      deny_access I18n.translate('sessions.authorization.access_denied.staff') unless staff?
    end
  
    # Sign-in to the backend as the specified user. Places a cookie for session tracking
    # and sets the current_backend_user. The backend_user to sign-in
    # must have been authenticated (e.g. checked credentials) before hand.
    def sign_in_to_backend(backend_user)
      cookies.permanent.signed[GAME_SERVER_CONFIG['cookie_name']] = [backend_user.id, backend_user.salt]
      self.current_backend_user = backend_user
    end
  
    # True, in case the present visitor has logged-in providing valid 
    # credentials of a registered identity. 
    def signed_in_to_backend?
      !current_backend_user.nil?
    end
  
    # True, in case the present user is an admin user.
    def backend_admin?
      !current_backend_user.nil? && current_backend_user.admin?
    end
  
    # True, in case the present user is a staff memeber. Admins always have
    # staff status, even when their staff flag hasn't been set properly.
    def backend_staff?
      backend_admin? || (!current_backend_user.nil? && current_backend_user.staff?) # admin is always staff
    end
  
    # Signs the present user out by destroying the cookie and unsetting
    # the current_identity .
    def sign_out_with_backend
      cookies.delete(GAME_SERVER_CONFIG['cookie_name'])
      self.current_backend_user = nil
    end
  
    # Sets the current_identity to the given identity.
    def current_backend_user=(identity)
      @current_backend_user = identity
    end
  
    # Returns the current_identity in case the present visitor has logged-in. If
    # no identity has been set (e.g. because its the first call to this getter),
    # the method tries to get the identity from the rember token stored in the
    # visitor's cookie. If the remember token hasn't been set, the visitor hasn't
    # authenticated himself so far and thus, the method returns nil. 
    #
    # Thus, this method realizes the session tracking.
    def current_backend_user 
      @current_backend_user ||= backend_user_from_remember_token # returns either the known identity or the one corresponding to the remember token
    end

    # Returns the identity matching the remember token or nil, if it hasn't been
    # set or is not valid.
    def backend_user_from_remember_token
      user = Backend::User.authenticate_with_salt(*remember_token)
      request_authorization[:grant_type] = :session
      request_authorization[:privileged] = true
      return user
#      user, ip = remember_token
#      if !user.blank? && request.remote_ip == ip
#        return user
#      else
#        return nil
#      end
    end

    # Returns either the remember_token that has been set in the cookie
    # or a nil - array.
    def remember_token
      cookies.signed[GAME_SERVER_CONFIG['cookie_name']] || [nil, nil]
    end
  
  
  end
end
