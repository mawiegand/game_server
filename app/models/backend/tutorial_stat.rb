class Backend::TutorialStat < ActiveRecord::Base 
  
  def self.update_all_cohorts
    Backend::TutorialStat.find(:all).each do |stat|
      stat.recalc_stats
      stat.save
    end
  end
  
  def recalc_stats
    self.reset_stats
    characters = Fundamental::Character.non_npc.where([ 'created_at <= ? AND created_at > ?', self.created_at, self.created_at - 1.days ])
    cohort_size = characters.count

    characters.each do |character|
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
    end
  end  
end
