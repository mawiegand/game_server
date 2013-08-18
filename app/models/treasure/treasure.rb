require 'util/formula'

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
  end
  
  
  
  def book_rewards_to_finder
    unless self.finder.nil?
      
    end
  end
  
  def random_amount(expectation, relative_deviation)
    relative_deviation ||= 0.0
    
    result = if relative_deviation <= 0.0
      expectation
    else
      deviation = expectation * relative_deviation
      begin
        number = gaussian(expectation, deviation, lambda { Kernel.rand })
      end while number < (expectation - 2*deviation) || number > (expectation + 2*deviation)
      
      number
    end
  end
  
  
  def gaussian(mean, stddev, rand)
    theta = 2 * Math::PI * rand.call
    rho = Math.sqrt(-2 * Math.log(1 - rand.call))
    scale = stddev * rho
    x = mean + scale * Math.cos(theta)
    y = mean + scale * Math.sin(theta)
    return x, y
  end
  
end
