# encoding: utf-8

class Fundamental::VictoryProgress < ActiveRecord::Base
  
  belongs_to  :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :victory_progresses
  
  before_save :update_first_fulfilled_at
  after_save  :check_for_victory
  
  VICTORY_TYPE_DOMINATION  = 0
  VICTORY_TYPE_ARTIFACTS   = 1
  VICTORY_TYPE_POPULARITY  = 2
  VICTORY_TYPE_SCIENCE     = 3
  
  # return the full days the condition of this victory_progress is already fulfilled
  def fulfilled_since
    self.first_fulfilled_at.nil? ? nil : ((Time.now - self.first_fulfilled_at)/(3600*24)).to_i
  end
  
  def recalc_fulfillment_count
    case self.victory_type
      when VICTORY_TYPE_DOMINATION
        return alliance.fortresses.count

      when VICTORY_TYPE_ARTIFACTS
        return 0
        
      when VICTORY_TYPE_POPULARITY
        return 0

      when VICTORY_TYPE_SCIENCE
        return 0

    end      
  end

    def fulfilled?
      case self.victory_type
        when VICTORY_TYPE_DOMINATION
          # TODO get required_region_ratio from rules
          rrr = 0.001
          # TODO get Map::Region.count from RoundInfo
          return self.fulfillment_count > Map::Region.count * rrr
  
        when VICTORY_TYPE_ARTIFACTS
          return false
  
        when VICTORY_TYPE_POPULARITY
          return false
  
        when VICTORY_TYPE_SCIENCE
          return false
      end      
    end

  private
  
    # the round is won if a victory condition is fulfilled for a specific amount of days
    def check_for_victory
      if !self.fulfilled_since.nil? && self.fulfilled_since >= 2
        logger.debug "Siegbedingung erfüllt!"
      else
        logger.debug "Siegbedingung nicht erfüllt!"
      end 
      true
    end
  
    def update_first_fulfilled_at
      fulfilled = self.fulfilled?
      if fulfilled && self.first_fulfilled_at.nil?
        self.first_fulfilled_at = Time.now
      elsif !fulfilled && !self.first_fulfilled_at.nil?
        self.first_fulfilled_at = nil
      end
      true
    end
end
