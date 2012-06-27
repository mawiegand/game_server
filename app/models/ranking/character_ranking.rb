class Ranking::CharacterRanking < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :ranking
  belongs_to :alliance,  :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"
  
  after_save :propagate_change_to_alliance
    
  protected
  
    def propagate_change_to_alliance
        logger.debug "PROPAGATE CHANGE TO ALLIANCE"

      if self.alliance_id_changed?
        logger.debug "CHANGED ALLIANCE ID"
        propagate_score_on_changed_alliance
      elsif !self.alliance.nil?
        logger.debug "ALLIANCE_ID HAS NOT CHANGED, ALLIANCE IS NOT NILL"

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
            puts "Delta: #{ delta }, change1: #{change[1]}, change0: #{change[2]}, field: #{field}."
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
      logger.debug "ON CHANGE ALLIANCE"
      alliance_change = self.changes[:alliance_id]
      if !alliance_change.nil?
        old_alliance = alliance_change[0].nil? ? nil : Ranking::AllianceRanking.find_by_alliance_id(alliance_change[0])
        new_alliance = alliance_change[1].nil? ? nil : Ranking::AllianceRanking.find_by_alliance_id(alliance_change[1])
        
        old_value = new_value = self.overall_score
        
        score_change = self.changes[:overall_score] 
        if !score_change.nil?
          new_value = (score_change[1] || 0)
          old_value = (score_change[0] || 0)
        end  
          
        puts "new: #{ new_value }, old: #{ old_value }, old_alliance: #{ old_alliance.inspect }, new_ally: #{ new_alliance.inspect }."
        logger.debug "new: #{ new_value }, old: #{ old_value }, old_alliance: #{ old_alliance.inspect }, new_ally: #{ new_alliance.inspect }."
          
          
        old_alliance.overall_score = (old_alliance.overall_score || 0) - old_value   unless old_alliance.nil?
        new_alliance.overall_score = (new_alliance.overall_score || 0) + new_value   unless new_alliance.nil? 

        old_alliance.save   unless old_alliance.nil?
        new_alliance.save   unless new_alliance.nil?
      end
      true      
    end
  
  
end
