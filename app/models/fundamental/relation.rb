class Fundamental::Relation
  
  RELATION_TYPE_UNKNOWN       =  0
  RELATION_TYPE_AT_WAR        =  5  
  RELATION_TYPE_NEUTRAL       = 10  
  RELATION_TYPE_ALLIED        = 15  
  RELATION_TYPE_SAME_ALLIANCE = 20  
  RELATION_TYPE_SELF          = 30  
  
  def self.relation_to_alliance(other_alliance_id)
    if other_alliance_id.nil?
      return RELATION_TYPE_UNKNOWN
    end  
      
    return self.relation_to(nil, other_alliance_id);
  end

  def self.is_relation_to_alliance_at_least(other_alliance_id, relation_type, or_unknown)
    if or_unknown.nil?
      or_unknown = false
    end
    
    rel = self.relation_to_alliance(other_alliance_id)
    return rel >= relation_type || (or_unknown && rel == RELATION_TYPE_UNKNOWN);
  end

  def self.relation_to_character(other_character_id)
    if other_character_id.nil?
      RELATION_TYPE_UNKNOWN
    end
    
    other_character = Fundamental::Character.find_by_id_or_identifier(other_character_id)
    
    if otherCharacter.nil?
      return RELATION_TYPE_UNKNOWN
    end  
      
    return self.relation_to(other_character_id, other_character.alliance_id)
  end

  def self.is_relation_to_character_at_least(other_character_id, relation_type, or_unknown)
    if or_unknown.nil?
      or_unknown = false
    end
    
    rel = self.relation_to_character(other_character_id)
    return rel >= relation_type || (or_unknown && rel == RELATION_TYPE_UNKNOWN);
  end
    
  def self.relation_to(other_character_id, other_alliance_id)
    if current_character_id.nil?
      return RELATION_TYPE_UNKNOWN
    end

    current_character = Fundamental::Character.find_by_id_or_identifier(current_character_id)
    current_alliance_id = current_character.alliance_id
      
    if current_alliance_id === other_character_id
      return RELATION_TYPE_SELF
    elsif current_alliance_id.nil?
      return RELATION_TYPE_NEUTRAL
    elsif other_alliance_id.nil?
      return RELATION_TYPE_NEUTRAL
    elsif current_alliance_id === other_alliance_id
      return RELATION_TYPE_SAME_ALLIANCE
    else
      return RELATION_TYPE_UNKNOWN
    end
  end

  def self.is_relation_to_at_least(other_character_id, other_alliance_id, relation_type, or_unknown)
    if or_unknown.nil?
      or_unknown = false
    end
    
    rel = self.relation_to(other_character_id, other_alliance_id)
    return rel >= relation_type || (or_unknown && rel == RELATION_TYPE_UNKNOWN);
  end

end
