class Ranking::CharacterRanking < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :ranking
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"
  
  after_save :propagate_change_to_alliance
    
  protected
  
    def propagate_change_to_alliance
      
      alliance = self.character.alliance
      
      return if alliance.nil?
      
      fields_to_propagate = [
        :resource_score,
        :overal_score,
      ] 
      
      set_clause = ""
      
      fields_to_propagate.each do |field|
        if !self.changes[field].nil?
          delta = self.changes[field][1] - self.changes[field][2]
          set_clause = set_clause + (set_clause.length == 0 ? "" : ", ") + "#{field.to_s} = #{field.to_s} + (#{delta})"
        end
      end
      
      if (set_clause.length > 0)
        alliance.update_all(set_clause) 
      end
    true
  end
  
  
end
