class Backend::TutorialStat < ActiveRecord::Base 
  
  def self.update_all_cohorts
    Backend::TutorialStat.find(:all).each do |stat|
      stat.recalc_stats
      stat.save
    end
  end
  
  def self.required_quest(quest)
    return nil   if quest.nil? || quest[:requirement].nil?
    uid = quest[:requirement][:quest]
    return nil   if uid.nil?

    Tutorial::Tutorial.the_tutorial.quests.each do |q|
      return q   if q[:symbolic_id] == uid.to_sym
    end
    
    nil
  end  
  
  def recalc_stats
    self.reset_stats
    characters = Fundamental::Character.non_npc.where([ 'created_at <= ? AND created_at > ?', self.created_at, self.created_at - 1.days ])
    self.cohort_size      = characters.count
    self.week_cohort_size = Fundamental::Character.non_npc.where([ 'created_at <= ? AND created_at > ?', self.created_at, self.created_at - 1.weeks ]).count

    characters.each do |character|
      unless character.tutorial_state.nil?
        character.tutorial_state.quests.each do |quest|
          if !quest.finished_at.nil?  && !self["quest_#{quest.quest_id}_num_finished".to_s].nil? # check whether database field already exists. may be not the case for newly created quests
            if quest.finished_at < character.created_at + 1.days
              self["quest_#{quest.quest_id}_num_finished_day_1".to_s] += 1
              self["quest_#{quest.quest_id}_playtime_finished_day_1".to_s] += (quest.playtime_finished || 0)
            end
            self["quest_#{quest.quest_id}_num_finished".to_s] += 1
            self["quest_#{quest.quest_id}_playtime_finished".to_s] += (quest.playtime_finished || 0)
          end
        
          if !quest.created_at.nil? && !self["quest_#{quest.quest_id}_num_started".to_s].nil?
            if quest.created_at < character.created_at + 1.days
              self["quest_#{quest.quest_id}_num_started_day_1".to_s] += 1
              self["quest_#{quest.quest_id}_playtime_started_day_1".to_s] += (quest.playtime_started || 0.0)
            end
            self["quest_#{quest.quest_id}_num_started".to_s] += 1
            self["quest_#{quest.quest_id}_playtime_started".to_s] += (quest.playtime_started || 0.0)
          end        
        end
      end
    end
    
    # the following is just a quick approximation of the real calculation. this should be calculated on real cohorts or even player basis.
    Tutorial::Tutorial.the_tutorial.quests.each do |quest| 
      prev_quest = Backend::TutorialStat.required_quest(quest)
      if !prev_quest.nil?
        quest_finished      = Tutorial::Quest.where( quest_id:      quest[:id] ).where(["state_id > ?", Tutorial::Quest::STATE_FINISHED]).where([ 'updated_at <= ? AND updated_at > ?', self.updated_at, self.updated_at - 1.weeks ]).count
        prev_quest_finished = Tutorial::Quest.where( quest_id: prev_quest[:id] ).where(["state_id > ?", Tutorial::Quest::STATE_FINISHED]).where([ 'updated_at <= ? AND updated_at > ?', self.updated_at, self.updated_at - 1.weeks ]).count
        self["quest_#{quest[:id]}_retention_rate_week_1".to_s] = (quest_finished || 0).to_f / ([prev_quest_finished || 1, 1].max).to_f
      end
    end    
  end  
  
  def reset_stats
    Tutorial::Tutorial.the_tutorial.quests.each do |quest|
      self["quest_#{quest[:id]}_num_started_day_1".to_s] = 0
      self["quest_#{quest[:id]}_num_finished_day_1".to_s] = 0
      self["quest_#{quest[:id]}_playtime_started_day_1".to_s] = 0.0
      self["quest_#{quest[:id]}_playtime_finished_day_1".to_s] = 0.0

      self["quest_#{quest[:id]}_num_started".to_s] = 0
      self["quest_#{quest[:id]}_num_finished".to_s] = 0
      self["quest_#{quest[:id]}_playtime_started".to_s] = 0.0
      self["quest_#{quest[:id]}_playtime_finished".to_s] = 0.0
      
      self["quest_#{quest[:id]}_retention_rate_week_1".to_s] = 0.0      
    end
  end  
end
