class Ranking::CharacterRanking < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :ranking
  belongs_to :alliance,  :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"
  
  after_save :propagate_change_to_alliance
    
  protected
  
    def propagate_change_to_alliance
      if self.alliance_id_changed?
        propagate_score_on_changed_alliance
      elsif !self.alliance.nil?

        fields_to_propagate = [
          :resource_score,
          :overall_score,
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
