class Backend::TutorialStat < ActiveRecord::Base 
  
  def self.update_all_cohorts
    Backend::TutorialStat.all.each do |stat|
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
              self["quest_#{quest.quest_id}_playtime_finished_day_1".to_s] += (quest.playtime_finished || 0).round(3)
            end
            self["quest_#{quest.quest_id}_num_finished".to_s] += 1
            self["quest_#{quest.quest_id}_playtime_finished".to_s] += (quest.playtime_finished || 0).round(3)
          end
        
          if !quest.created_at.nil? && !self["quest_#{quest.quest_id}_num_started".to_s].nil?
            if quest.created_at < character.created_at + 1.days
              self["quest_#{quest.quest_id}_num_started_day_1".to_s] += 1
              self["quest_#{quest.quest_id}_playtime_started_day_1".to_s] += (quest.playtime_started || 0.0).round(3)
            end
            self["quest_#{quest.quest_id}_num_started".to_s] += 1
            self["quest_#{quest.quest_id}_playtime_started".to_s] += (quest.playtime_started || 0.0).round(3)
          end        
        end
      end
    end
    
    # the following is just a quick approximation of the real calculation. this should be calculated on real cohorts or even player basis.
    Tutorial::Tutorial.the_tutorial.quests.each do |quest| 
      prev_quest = Backend::TutorialStat.required_quest(quest)
      if !prev_quest.nil?
        quest_finished      = Tutorial::Quest.where( quest_id:      quest[:id] ).where(["state_id > ?", Tutorial::Quest::STATE_FINISHED]).where([ 'updated_at <= ? AND updated_at > ?', self.created_at, self.created_at - 1.weeks ]).count
        prev_quest_finished = Tutorial::Quest.where( quest_id: prev_quest[:id] ).where(["state_id > ?", Tutorial::Quest::STATE_FINISHED]).where([ 'updated_at <= ? AND updated_at > ?', self.created_at, self.created_at - 1.weeks ]).count
        self["quest_#{quest[:id]}_retention_rate_week_1".to_s] = ((quest_finished || 0).to_f / ([prev_quest_finished || 1, 1].max).to_f).round(3)
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



  def self.download_tutorial_stats_csv(backend_tutorial_stats)


    header = []

    csv_file = CSV.generate({:col_sep => ";"}) do |csv|

      header.push("Created At")
      header.push("Cohort Size")
      header.push("Description")

      #appending the header text     
      Tutorial::Tutorial.the_tutorial.quests.each do |quest| 
        header.push(quest[:name][:en_US].to_s + "\n" + quest[:id].to_s)
        header.push("")
      end

      csv << header

     
      # appending the rows
      backend_tutorial_stats.each do |backend_tutorial_stat|
      
        cell_row1 = []
        cell_row2 = []
        cell_row3 = []

        cohort_size = backend_tutorial_stat.cohort_size

        cell_row1.push(backend_tutorial_stat.created_at)
        cell_row1.push(backend_tutorial_stat.cohort_size)

        # to leave empty cells and keep the data organized according to file.
        cell_row2.push("")
        cell_row2.push("")

        cell_row3.push("")
        cell_row3.push("")

        cell_row1.push("Quest Finished ( Day 1 )")
        cell_row2.push("Quest Finished")
        cell_row3.push("Play Time")

        Tutorial::Tutorial.the_tutorial.quests.each do |quest| 
          prev_quest = required_quest(quest)


          exported_value = backend_tutorial_stat["quest_#{quest[:id]}_num_finished_day_1".to_s]

          binding.pry
          cell_row1.push(exported_value)
          cell_row1.push(((exported_value/cohort_size)*100).to_s + "%")


          exported_value = backend_tutorial_stat["quest_#{quest[:id]}_num_finished".to_s]

          cell_row2.push(backend_tutorial_stat["quest_#{quest[:id]}_num_finished".to_s])
          cell_row2.push(((exported_value/cohort_size)*100).to_s + "%")

          time = ((backend_tutorial_stat["quest_#{quest[:id]}_playtime_finished".to_s] || 0).floor)
          time = time/1000

          cell_row3.push(time.to_s + "s")
          cell_row3.push("")


          if !prev_quest.nil? && (backend_tutorial_stat["quest_#{prev_quest[:id]}_num_finished_day_1".to_s] || 0) > 0
            cell_row3[1] =  ("#{((backend_tutorial_stat["quest_#{quest[:id]}_num_finished_day_1".to_s] || 0).to_f / (backend_tutorial_stat["quest_#{prev_quest[:id]}_num_finished_day_1".to_s] || 1) * 100).floor}%").to_s + "s" 
          else 
          end 

          #row.push(quest_value[0].to_s+"\n"+quest_value[1].to_s+"\n"+quest_value[2].to_s)
        end
        csv << cell_row1
        csv << cell_row2
        csv << cell_row3
      end

    end # csv end
  
    return csv_file
  end
end
