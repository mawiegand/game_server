require 'util/formula'
require 'util/random_gaussian'

class Treasure::Treasure < ActiveRecord::Base

  belongs_to :finder,    :class_name => "Fundamental::Character", :foreign_key => "character_id" , :inverse_of => :treasures

  before_create :fill_rewards
  after_create :book_rewards_to_finder
  
  
  
  def treasure_type
    self.category.nil? ? nil : GameRules::Rules.the_rules.treasure_types[self.category.to_i]    
  end
  
  
  def fill_rewards
    type = self.treasure_type
    
    xp_reward = type[:rewards][:randomized_experience_reward]
    
    if !xp_reward.nil?
      relative_deviation = xp_reward[:norm_variance]
      expectation = Util::Formula.parse_from_formula(xp_reward[:amount]).apply(self.level)
    
      self.experience_reward = self.random_amount(expectation, relative_deviation) || 0
    else 
      self.experience_reward = self.random_amount(expectation, relative_deviation) || 0
    end
    
    if type[:rewards].has_key?(:randomized_resource_rewards)
      type[:rewards][:randomized_resource_rewards].each do |resource_reward|

        relative_deviation = resource_reward[:norm_variance]
        expectation = Util::Formula.parse_from_formula(resource_reward[:amount]).apply(self.level)

        result = self.random_amount(expectation, relative_deviation)
        self["#{resource_reward[:resource]}_reward"] = result || 0
      end
    end
    true
  end
  
  
  
  def book_rewards_to_finder
    unless self.finder.nil?

      resource_rewards = {}
      GameRules::Rules.the_rules.resource_types.each do |resource_type|
        resource_reward = self[resource_type[:symbolic_id].to_s + '_reward']
        resource_rewards[resource_type[:id]] = resource_reward if !resource_reward.nil? && resource_reward > 0
      end

      if resource_rewards.count > 0
        self.finder.resource_pool.add_resources_transaction(resource_rewards)
      end

      if !self.experience_reward.nil? && self.experience_reward > 0
        self.finder.increment(:exp, self.experience_reward)
        self.finder.save!
      end
            
    end
    true
  end
  
  def random_amount(expectation, relative_deviation)
    relative_deviation ||= 0.0
    
    result = if relative_deviation <= 0.0
      expectation
    else
      deviation = expectation * relative_deviation
      begin
        number = gaussian(expectation, deviation)
      end while number < (expectation - 2*deviation) || number > (expectation + 2*deviation)
      
      number
    end
  end
  
  
  def gaussian(mean, stddev)
    generator = Util::RandomGaussian.new(mean, stddev)
    generator.rand
  end
  
end
