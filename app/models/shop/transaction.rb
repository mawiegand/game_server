class Shop::Transaction < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"

  STATES = []
  STATE_CREATED = 1
  STATES[STATE_CREATED] = :created
  STATE_REJECTED = 2
  STATES[STATE_REJECTED] = :rejected
  STATE_CONFIRMED = 3
  STATES[STATE_CONFIRMED] = :confirmed
  STATE_COMMITTED = 4
  STATES[STATE_COMMITTED] = :committed
  STATE_CLOSED = 5
  STATES[STATE_CLOSED] = :closed
  STATE_ABORTED = 6
  STATES[STATE_ABORTED] = :aborted
  STATE_ERROR_NO_CONNECTION = 7
  STATES[STATE_ERROR_NO_CONNECTION] = :error_no_connection
  STATE_ERROR_NOT_BOOKED = 8
  STATES[STATE_ERROR_NOT_BOOKED] = :error_not_booked
  STATE_BOOKED = 9  
  STATES[STATE_BOOKED] = :booked
  
  TYPE_CREDIT = 0
  TYPE_DEBIT = 1
  
  API_RESPONSE_OK = 0
  API_RESPONSE_ERROR = 1
end
