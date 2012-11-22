require 'credit_shop'

class Fundamental::RetentionMail < ActiveRecord::Base
  
  belongs_to  :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :retention_mails
  
  after_create :propagate_last_retention_mail
  before_save  :add_identifier
   
  def redeem_credit_reward
    booking_amount = -self.credit_reward    # for adding credits the amount has to be negative
    return false if booking_amount >= 0
    
    # lokale transaction erzeugen
    shop_transaction = Shop::Transaction.create({
      character: character,
      offer: 'redeemed retention mail reward',
      state: Shop::Transaction::STATE_CREATED
    })
    
    # transaction zum payment provider schicken
    virtual_bank_transaction = {
      customer_identifier: character.identifier,
      credit_amount_booked: booking_amount,
      booking_type: booking_amount > 0 ? Shop::Transaction::TYPE_DEBIT : Shop::Transaction::TYPE_CREDIT,
      transaction_id: shop_transaction.id,
    }
    
    account_response = CreditShop::BytroShop.get_customer_account(character.identifier)
    return false unless account_response[:response_code] == Shop::Transaction::API_RESPONSE_OK
    credit_amount = account_response[:response_data][:amount]
     
    shop_transaction.credit_amount_before = credit_amount
    shop_transaction.save
    
    transaction_response = CreditShop::BytroShop.post_virtual_bank_transaction(virtual_bank_transaction, character.identifier)
    if transaction_response[:response_code] === Shop::Transaction::API_RESPONSE_OK
      shop_transaction.credit_amount_after = transaction_response[:response_data][:amount]
      shop_transaction.state = Shop::Transaction::STATE_CLOSED
      shop_transaction.credit_amount_booked = booking_amount
      shop_transaction.save
    else
      false
    end
  end
  
  protected
  
    def propagate_last_retention_mail
      character.last_retention_mail = self
      character.last_retention_mail_sent_at = Time.now
      character.save
    end
  
    def add_identifier
      begin
        self.identifier = make_random_string(16)
      end while !Fundamental::RetentionMail.find_by_identifier(self.identifier).nil?
    end  
  
    def make_random_string(len = 64)
      chars = ('a'..'z').to_a + ('A'..'Z').to_a
      (0..(len-1)).collect { chars[Kernel.rand(chars.length)] }.join
    end    
  
end
