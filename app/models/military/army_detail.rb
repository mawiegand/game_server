class Military::ArmyDetail < ActiveRecord::Base

  belongs_to :army, :class_name => "Military::Army", :foreign_key => "army_id", :touch => true, :inverse_of => :details

  before_save :check_size
  after_save  :update_army
  

  def reduce_units_to_size_max

    # calculate size_present
    size_present = 0
    GameRules::Rules.the_rules.unit_types.each do |type|
      size_present += (self[type[:db_field]] || 0)
      #logger.debug "---> size_present: #{size_present}"
    end

    ratio =  army.size_max.to_f / size_present
    size = 0     

    # reduce units according to ratio
    GameRules::Rules.the_rules.unit_types.each do |type|
      type_name = type[:db_field]
      orig = self[type_name] || 0
      self[type_name] = ((self[type_name] || 0) * ratio).ceil  # don't reduce too much => ceil
      size += self[type_name]
      # logger.debug "---> #{type_name} reducing by ratio #{ratio} from #{orig} to #{self[type_name]}, current size #{size}"
    end
    
    # reduce every unit type by 1 unit until size present meets size maximum    
    GameRules::Rules.the_rules.unit_types.each do |type|
      if size > army.size_max && (self[type[:db_field]] || 0) > 0
        self[type[:db_field]] -= 1
        size -= 1 
        # logger.debug "---> #{type[:db_field]} reducing by 1 to #{self[type[:db_field]]}, current size #{size}"
      end
    end
    
    self.save
  end

  private
  
    def check_size
      n = 0
      GameRules::Rules.the_rules.unit_types.each do | unit_type |
        n += self[unit_type[:db_field]] || 0
      end
      logger.debug "army size #{ n }, max size #{ army.size_max }"
      raise ForbiddenError.new "army would be larger than the presently imposed size limit" unless n <= army.size_max
    end
  
    def update_army
      self.army.update_from_details
    end

end
