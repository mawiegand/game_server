# encoding: utf-8

require 'credit_shop'
require 'util'

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
  
  def subject
    if mail_type == 'played_too_short'
      I18n.translate('application.retention.subject.played_too_short', locale: character.lang)
    elsif mail_type == 'paused_too_long'
      I18n.translate('application.retention.subject.paused_too_long', locale: character.lang)
    elsif mail_type == 'getting_inactive'
      I18n.translate('application.retention.subject.getting_inactive', locale: character.lang, :name => character.name, :credit_reward => credit_reward)
    elsif mail_type == 'getting_deleted'
      I18n.translate('application.retention.subject.getting_deleted', locale: character.lang)
    end
  end
  
  def body
    if mail_type == 'played_too_short'
      I18n.translate('application.retention.body.played_too_short', locale: character.lang, :name => character.name, :url => GAME_SERVER_CONFIG['base_url'])
    elsif mail_type == 'paused_too_long'
      I18n.translate('application.retention.body.paused_too_long', locale: character.lang, :name => character.name, :url => GAME_SERVER_CONFIG['base_url'])
    elsif mail_type == 'getting_inactive'
      I18n.translate('application.retention.body.getting_inactive', locale: character.lang, :name => character.name, :url => GAME_SERVER_CONFIG['base_url'], :credit_reward => credit_reward)
    elsif mail_type == 'getting_deleted'
      I18n.translate('application.retention.body.getting_deleted', locale: character.lang, :name => character.name, :url => GAME_SERVER_CONFIG['base_url'])
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
        self.identifier = Util.make_random_string(16)
      end while !Fundamental::RetentionMail.find_by_identifier(self.identifier).nil?
    end  
end
