class Google::ProxyController < ApplicationController
  layout 'google'

  # before_filter :authenticate

  def verify_order

    package_name         = params['package_name']
    product_id           = params['product_id']
    payment_token        = params['payment_token']
    google_access_token  = params['google_access_token']

    unless package_name.blank? || product_id.blank? || payment_token.blank? || google_access_token.blank?
      google_response = HTTParty.get(
        "https://www.googleapis.com/androidpublisher/v2/applications/#{package_name}/purchases/products/#{product_id}/tokens/#{payment_token}?access_token=#{google_access_token}",
        verify: false,
      )
      logger.debug "googe proxy, verify_order | api response: #{google_response}"

      render(json: google_response, status: :ok)
    else
      logger.debug "googe proxy, verify_order | bad_request"
      render(json: {error: 'google api call failed'}, status: :bad_request)
    end
  end

end
