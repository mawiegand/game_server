class Event::Event < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"  
  
  
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
