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
  
  def apply_victory_progress_for_type(type)
    fulfillment_ratio = 0
    case type
      when VICTORY_TYPE_DOMINATION
        # size ratio of dominated area
        domination_ratio = alliance.fortresses.count.to_f / Settlement::Settlement.where(:type_id => Settlement::Settlement::TYPE_FORTESS).count
        # calc fulfillment ratio of victory condition
        required_domination_ratio = 0.001 # TODO aus Regeln holen
        self.fulfillment_ratio = domination_ratio / required_domination_ratio

      when VICTORY_TYPE_ARTIFACTS
        self.fulfillment_ratio = 0

      when VICTORY_TYPE_POPULARITY
        self.fulfillment_ratio = 0

      when VICTORY_TYPE_SCIENCE
        self.fulfillment_ratio = 0

    end      
    self.save
  end

  private
  
    def check_for_victory
      case self.victory_type
      when VICTORY_TYPE_DOMINATION
        # TODO get victory condition from rules
        if !self.fulfilled_since.nil? && self.fulfilled_since >= 2
          logger.debug "Siegbedingung erfüllt!"
        else
          logger.debug "Siegbedingung nicht erfüllt!"
        end 
      when VICTORY_TYPE_ARTIFACTS
        # puts "Foo is between 2 and 9"
      when VICTORY_TYPE_POPULARITY
        # puts "Foo is equal to 10"
      when VICTORY_TYPE_SCIENCE
        # puts 'peng'
      end      
      true
    end
  
    def update_first_fulfilled_at
      if self.fulfillment_ratio >= 1 && self.first_fulfilled_at.nil?
        self.first_fulfilled_at = Time.now
      elsif self.fulfillment_ratio < 1 && !self.first_fulfilled_at.nil?
        self.first_fulfilled_at = nil
      end
      true
    end
end
