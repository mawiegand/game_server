class BadRequestError             < ArgumentError
end

class NotFoundError               < ArgumentError
end

class ConflictError               < ArgumentError   # 409
end

class UnprocessableEntityError    < ArgumentError   # 422
end

class UnauthorizedError           < RuntimeError
end

class ForbiddenError              < RuntimeError
end


# HTTP Status Code 500
#
# W3 (RFC 2616): The server encountered an unexpected condition which 
# prevented it from fulfilling the request.
class InternalServerError         < RuntimeError   # 500
end


# HTTP Status Code 501
#
# W3 (RFC 2616): The server does not support the functionality required
# to fulfill the request. This is the appropriate response when the server 
# does not recognize the request method and is not capable of supporting 
# it for any resource.
#class NotImplementedError         < RuntimeError   # 501
#end


# HTTP Status Code 503
#
# W3 (RFC 2616): The server is currently unable to handle the request due
# to a temporary overloading or maintenance of the server. The implication 
# is that this is a temporary condition which will be alleviated after some 
# delay. If known, the length of the delay MAY be indicated in a Retry-After 
# header. If no Retry-After is given, the client SHOULD handle the response 
# as it would for a 500 response.
class ServiceUnavailableError     < RuntimeError   # 503
end

class BearerAuthError             < RuntimeError
end

# Error thrown in case an attempt to authorize a request with a bearer token
# fails due to an invalid request (e.g. due to missing or duplicate 
# parameters). See draft-ietf-oauth-v2-bearer-08 for more details.
class BearerAuthInvalidRequest    < BearerAuthError
end

# Error thrown in case an attempt to authorize a request with a bearer token
# fails due to an invalid token (e.g. malformed, expired). 
# See draft-ietf-oauth-v2-bearer-08 for more details.
class BearerAuthInvalidToken      < BearerAuthError
end

# Error thrown in case an attempt to authorize a request with a bearer token
# fails due to an authorization to a too narrow scope in.  
# See draft-ietf-oauth-v2-bearer-08 for more details.
class BearerAuthInsufficientScope < BearerAuthError
end