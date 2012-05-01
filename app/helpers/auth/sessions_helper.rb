module Auth
  module SessionsHelper

  
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
      cookies.permanent.signed[:remember_token] = [backend_user.id, backend_user.salt]
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
      cookies.delete(:remember_token)
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
      identity = Backend::User.authenticate_with_salt(*remember_token)
#      request_authorization[:grant_type] = :session
#      request_authorization[:privileged] = true
      return identity
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
      cookies.signed[:remember_token] || [nil, nil]
    end
  
  
  end
end
