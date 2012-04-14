include ActionView::Helpers::DateHelper

class Fundamental::AllianceShout < ActiveRecord::Base
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"  
  
  def posted_ago_in_words
    time_ago_in_words(created_at)
  end
end
