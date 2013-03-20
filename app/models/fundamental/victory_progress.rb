# encoding: utf-8

require 'util/formula'

class Fundamental::VictoryProgress < ActiveRecord::Base
  
  belongs_to  :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :victory_progresses
  
  before_save :update_first_fulfilled_at

  after_find  :check_for_victory

  VICTORY_TYPE_DOMINATION  = 0
  VICTORY_TYPE_ARTIFACTS   = 1
  VICTORY_TYPE_POPULARITY  = 2
  VICTORY_TYPE_SCIENCE     = 3

  def victory_type
    GameRules::Rules.the_rules.victory_types[self.type_id]
  end

  # return the full days the condition of this victory_progress is already fulfilled
  def fulfilled_since
    self.first_fulfilled_at.nil? ? nil : ((Time.now - self.first_fulfilled_at)/(3600*24)).to_i
  end

  def recalc_fulfillment_count
    case self.type_id
      when VICTORY_TYPE_DOMINATION                                # count fortresses of alliance
        self.alliance.fortresses.count

      when VICTORY_TYPE_ARTIFACTS                                 # count distinct initiated artifact types of alliance
        self.alliance.artifacts.where('initiated = ?', true).select('distinct type_id').count
        
      else
        0
    end
  end

  # gets  victory conditions from rules and current settings from round info to check
  # if alliance has already reached the victory
  def fulfilled?
    case self.type_id
      when VICTORY_TYPE_DOMINATION
        round_info = Fundamental::RoundInfo.the_round_info
        # evaluate required_regions_ratio as formula
        formula = Util::Formula.parse_from_formula(self.victory_type[:condition][:required_regions_ratio], 'DAYS')
        required_regions_ratio = formula.apply(round_info.age)   
        self.fulfillment_count > round_info.regions_count * required_regions_ratio

      when VICTORY_TYPE_ARTIFACTS
        self.fulfillment_count >= GameRules::Rules.the_rules.artifact_count

      else
        false
    end      
  end

  protected

    def set_victory_gained(victory_time)
      self.transaction do
        logger.debug "Siegbedingung erfüllt!"
        self.victory_gained = true
        self.save
        round_info = Fundamental::RoundInfo.the_round_info.lock!
        round_info.set_victory_gained(self, victory_time)
      end
    end
  
    # the round is won if a victory condition is fulfilled for a specific amount of days
    def check_for_victory
      return true if self.fulfilled_since.nil?
      return true if self.victory_type[:condition].nil? || self.victory_type[:condition][:duration].nil?

      return true if Fundamental::RoundInfo.the_round_info.victory_gained?

      victory_time = self.first_fulfilled_at + self.victory_type[:condition][:duration].days

      # set victory gained
      self.set_victory_gained(victory_time) if victory_time < Time.now
      true
    end
  
    def update_first_fulfilled_at
      if self.fulfilled? && self.first_fulfilled_at.nil?
        self.first_fulfilled_at = Time.now
      elsif !self.fulfilled? && !self.first_fulfilled_at.nil?
        self.first_fulfilled_at = nil
      end
      true
    end
end
