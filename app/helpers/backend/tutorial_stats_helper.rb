module Backend::TutorialStatsHelper
  
  def required_quest(quest)
    return nil   if quest.nil? || quest[:requirement].nil?
    uid = quest[:requirement][:quest]
    return nil   if uid.nil?

    Tutorial::Tutorial.the_tutorial.quests.each do |q|
      return q   if q[:symbolic_id] == uid.to_sym
    end
    
    nil
  end
  
end
