class Event::Event < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"  
  
  scope :blocked,         where('locked_at IS NOT NULL')
  scope :executed_before, lambda { |date| where(['execute_at < ?', date]) }
  scope :battle,          where(event_type: 'military_battle')
  
  def self.unlock_all
    Event::Event.all.each do |event|
      event.unlock
      event.save
    end
  end
  
  def unlock
    self.locked_by = nil
    self.locked_at = nil
  end
  
end
