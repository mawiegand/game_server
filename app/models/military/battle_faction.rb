class Military::BattleFaction < ActiveRecord::Base

  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :factions,    :counter_cache => true

  has_many   :participants, :class_name => "Military::BattleParticipant", :foreign_key => "faction_id", :inverse_of => :faction  
  has_many   :faction_results, :class_name => "Military::BattleFactionResult", :foreign_key => "faction_id", :inverse_of => :faction

  belongs_to :leader, :class_name => "Fundamental::Character", :foreign_key => "leader_id", :inverse_of => :leads_battle_factions

  def update_from_participants
    strength_per_cat = {};
    
    GameRules::Rules.the_rules.unit_categories.each do | unit_category |
      field = (unit_category[:db_field].to_s+'_strength').to_sym
      self[field] = 0
    end
  
    self.participants.each do | participant |
      GameRules::Rules.the_rules.unit_categories.each do | unit_category |        
        field = (unit_category[:db_field].to_s+'_strength').to_sym
        Rails.logger.debug field
        Rails.logger.debug self
        Rails.logger.debug participant
        Rails.logger.debug self.participants

        self[field] += participant.army.send(field)
      end
    end    
  end

  def update_from_participants!
    update_from_participants
    self.save
  end

  def has_units_fighting?
    participants.each do |p|
      logger.debug("p.id="+p.id.to_s+", p.retreated="+p.retreated.to_s+", p.has_units?="+p.has_units?.to_s)
      return true if (!p.retreated && p.has_units?)
    end
    false
  end


  def update_leader
    #check if current leader has still units
    participants.each do |participant|
      if (participant.army.owner_id == leader_id && !participant.army.empty?)
        return true
      end
    end

    #find a new leader
    best_army = nil
    participants.each do |participant|
      if (best_army.nil? && !participant.army.empty?)
        best_army = participant.army
      elsif (!best_army.nil? && !participant.army.empty? && participant.army.strength > best_army.strength)
        best_army = participant.army
      end
    end

    #if there was found a new leader save him
    if !best_army.nil?
      self.leader_id = best_army.owner_id
      return self.save
    else
      true
    end
  end

end
