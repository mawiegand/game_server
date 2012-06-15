class Training::Queue < ActiveRecord::Base
  
  belongs_to  :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :training_queues

  before_save :update_speed

  def add_speedup(origin_type, delta)
    if origin_type    == :building
      self.speedup_buildings = self.speedup_buildings + delta
    elsif origin_type == :sciences
      self.speedup_sciences = self.speedup_sciences + delta
    elsif origin_type == :alliance
      self.speedup_alliance = self.speedup_alliance + delta
    elsif origin_type == :effects
      self.speedup_effects = self.speedup_effects + delta
    else 
      raise InternalServerError.new('Could not add speedup bonus of type #{origin_type.to_s}.');
    end
  end

  protected
  
    def update_speed
      sum = 1.0 + self.speedup_buildings + self.speedup_sciences + self.speedup_alliance + self.speedup_effects
      self.speed = sum < 0.00001 ? 0.00001 : sum
    end

end
