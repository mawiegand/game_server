class Military::BattleFaction < ActiveRecord::Base

  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :factions,    :counter_cache => true

  has_many   :participants, :class_name => "Military::BattleParticipant", :foreign_key => "battle_id", :inverse_of => :faction  


  def update_from_participants
    strength_per_cat = {};
    
    GameRules::Rules.the_rules.unit_categories.each do | unit_category |
      field = (unit_category[:db_field].to_s+'_strength').to_sym
      self[field] = 0
    end
  
    self.participants.each do | participant |
      GameRules::Rules.the_rules.unit_categories.each do | unit_category |        
        field = (unit_category[:db_field].to_s+'_strength').to_sym
        self[field] += participant.army[field]
      end
    end    
  end

  def update_from_participants!
    update_from_participants
    self.save
  end

end
