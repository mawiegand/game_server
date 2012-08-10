class Military::ArmyDetail < ActiveRecord::Base

  belongs_to :army, :class_name => "Military::Army", :foreign_key => "army_id", :touch => true, :inverse_of => :details

  before_save :check_size
  after_save  :update_army

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
