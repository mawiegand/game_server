require 'credit_shop'

class Shop::FbPaymentsController < ApplicationController

  VERIFY_TOKEN = 'UKUKvzHHAg8gjXynx3hioFX7nC8KLa'

  def callback
    render text: params['hub.challenge']
  end

end
