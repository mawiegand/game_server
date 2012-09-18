require 'credit_shop/five_d_payment_provider'
require 'credit_shop/bytro_shop'

module CreditShop
  
  def self.credit_shop(request)
    CreditShop::FiveDPaymentProvider.new(request)
    # CreditShop::BytroShop.new(request)
  end
  
end