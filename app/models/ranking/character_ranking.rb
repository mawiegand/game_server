class Ranking::CharacterRanking < ActiveRecord::Base
  
  belongs_to :character,              :class_name => "Fundamental::Character", :foreign_key => "character_id",           :inverse_of => :ranking
  belongs_to :alliance,               :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"
  belongs_to :most_experienced_army,  :class_name => "Military::Army",         :foreign_key => "max_experience_army_id", :inverse_of => :ranking
  
  before_save :update_ratios
  after_save  :propagate_change_to_alliance
    
  def self.update_ranks(sort_field=:overall_score, rank_field=:overall_rank)
    rankings = Ranking::CharacterRanking.find(:all, :order => "#{sort_field.to_s} DESC")
    rank = 1
    rankings.each do |entry| 
      entry[rank_field] = rank
      entry.save
      rank += 1
    end
  end
  
  def reset_max_experience
    self.max_experience           = 0
    self.max_experience_army_id   = nil
    self.max_experience_army_name = nil
    self.max_experience_army_rank = nil
  end
  
  def update_max_experience_from_army(army)
    self.max_experience           = army.exp
    self.max_experience_army_id   = army.id
    self.max_experience_army_name = army.name
    self.max_experience_army_rank = army.rank
  end
  
  def recalc_max_experience(ignore_army_id = -1)
    armies = self.character.armies.where(["id != ?", ignore_army_id]).order("exp DESC").limit(1)
    if !armies.blank? && armies.length == 1
      self.update_max_experience_from_army(armies[0])
    else 
      self.reset_max_experience
    end
  end
    
  protected
  
    def update_ratios
      self.like_ratio    = (likes || 0) / [(likes || 0) + (dislikes || 0), 1].max.to_f
      self.victory_ratio = (victories || 0) + (defeats || 0) == 0 ? 1.0 : (victories || 0) / ([(defeats || 0), 1].max).to_f
    end
  
    def propagate_change_to_alliance
      if self.alliance_id_changed?
        propagate_score_on_changed_alliance
      elsif !self.alliance.nil?

        fields_to_propagate = [
          :resource_score,
          :overall_score,
          :num_fortress,
          :kills,
        ] 
      
        set_clause = ""
      
        fields_to_propagate.each do |field|
          change = self.changes[field]
          if !change.nil?
            delta = (change[1] || 0) - (change[0] || 0)
            logger.debug "Delta: #{ delta }, change1: #{change[1]}, change0: #{change[2]}, field: #{field}."
            set_clause = set_clause + (set_clause.length == 0 ? "" : ", ") + "#{field.to_s} = #{field.to_s} + (#{delta})"
          end
        end
      
        if (set_clause.length > 0)
          Ranking::AllianceRanking.update_all(set_clause, :alliance_id => self.alliance.id) 
        end
      end
      true
    end
  
  
    def propagate_score_on_changed_alliance
      alliance_change = self.changes[:alliance_id]
      if !alliance_change.nil?
        old_alliance = alliance_change[0].nil? ? nil : Ranking::AllianceRanking.find_by_alliance_id(alliance_change[0])
        new_alliance = alliance_change[1].nil? ? nil : Ranking::AllianceRanking.find_by_alliance_id(alliance_change[1])
        
        fields_to_propagate = [
          :resource_score,
          :overall_score,
          :num_fortress,
          :kills,
        ] 
      
        fields_to_propagate.each do |field|
          old_value = new_value = self[field]

          change = self.changes[field]
          if !change.nil?
            new_value = (change[1] || 0)
            old_value = (change[0] || 0)
          end
          old_alliance[field] = (old_alliance[field] || 0) - old_value   unless old_alliance.nil?
          new_alliance[field] = (new_alliance[field] || 0) + new_value   unless new_alliance.nil? 

        end
        
        old_alliance.save unless old_alliance.nil?
        new_alliance.save unless new_alliance.nil?

      end
      true      
    end
  
end
