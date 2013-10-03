require 'credit_shop'

class Shop::FbPaymentsController < ApplicationController

  VERIFY_TOKEN = 'UKUKvzHHAg8gjXynx3hioFX7nC8KLa'

  def callback
    if params['hub.verify_token'] == VERIFY_TOKEN
      render text: params['hub.challenge']
    else
      render text: 'error'
    end
  end

end
