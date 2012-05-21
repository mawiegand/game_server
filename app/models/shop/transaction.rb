class Shop::Transaction < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"

  STATE_CREATED = 1
  STATE_REJECTED = 2
  STATE_CONFIRMED = 3
  STATE_COMMITTED = 4
  STATE_CLOSED = 5
  STATE_ABORTED = 6
  STATE_ERROR = 7
  
  TYPE_CREDIT = 0
  TYPE_DEBIT = 1
end
