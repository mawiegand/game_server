class Military::BattleFaction < ActiveRecord::Base

  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :factions,    :counter_cache => true, :touch => true

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
        #Rails.logger.debug field
        #Rails.logger.debug self
        #Rails.logger.debug participant
        #Rails.logger.debug self.participants
        #
        self[field] += participant.army.send(field) unless participant.army.nil?
      end
    end    
  end

  def update_from_participants!
    update_from_participants
    self.save
  end

  def has_units_fighting?
    participants.each do |p|
      logger.debug("p.id="+p.id.to_s+", p.retreated="+p.retreated.to_s+", p.disbanded=#{p.disbanded} p.has_units?="+p.has_units?.to_s)
      return true if (!p.retreated && !p.disbanded? && p.has_units?)
    end
    false
  end

  def participant_with_largest_army
    owner_of_largest_army = nil
    participants.each do |participant|
      if (owner_of_largest_army.nil? && !participant.army.nil? && !participant.army.empty?)
        owner_of_largest_army = participant
      elsif (!owner_of_largest_army.nil? &&  !participant.army.nil? && !participant.army.empty? && participant.army.strength > owner_of_largest_army.army.strength)
        owner_of_largest_army = participant
      end
    end
    
    owner_of_largest_army
  end

  def takeover_candidate_with_largest_army
    owner_of_largest_army = nil
    participants.each do |participant|
      if (owner_of_largest_army.nil? &&  !participant.army.nil? && !participant.army.empty? && participant.army.owner.can_takeover_settlement? && (battle.location.fortress? || battle.location.region.settleable_by?(participant.army.owner)))
        owner_of_largest_army = participant
      elsif (!owner_of_largest_army.nil? &&  !participant.army.nil? && !participant.army.empty? && participant.army.strength > owner_of_largest_army.army.strength && participant.army.owner.can_takeover_settlement? && (battle.location.fortress? || battle.location.region.settleable_by?(participant.army.owner)))  
        owner_of_largest_army = participant
      end
    end
    
    owner_of_largest_army
  end


  def update_leader
    #check if current leader has still units
    participants.each do |participant|
      if (!participant.army.nil? && participant.army.owner_id == leader_id && !participant.army.empty?)  # check for nil, because army may have died in battle
        return true
      end
    end

    #find a new leader
    strongest = participant_with_largest_army

    #if there was found a new leader save him
    if !strongest.nil?
      self.leader_id = strongest.army.owner_id
      self.save
    else
      true
    end
  end
  
  def set_winner
    self.winner = true
    self.save
  end
  
  def opposing_faction
    self.battle.factions.each do |faction|
      return faction if faction != self
    end
    nil
  end
  
  def contains_garrison?
    participants.each do |participant|
      return true if !participant.army.nil? && participant.army.garrison
    end
    false
  end
  
  def contains_army_of(character)
    participants.each do |participant|
      return true if participant.character_id == character.id
    end
    false
  end
  
  # get all characters of this faction without duplicates
  def characters
    chars = []
    participants.each do |participant|
      chars << participant.character unless chars.include?(participant.character)
    end
    chars
  end
  
  def count_victory
    self.characters.each do |character|
      character.increment!(:victories, 1)
    end
  end
  
  def count_defeat
    self.characters.each do |character|
      character.increment!(:defeats, 1)
    end
  end

  def strength
    strength = 0
    self.participants.each do |p|
      strength += p.army.strength unless p.army.nil?
    end
    strength
  end
end
