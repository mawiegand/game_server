require 'ticker/command'
require 'ticker/runloop'
class DummyRunloop
def say(arg, level = Logger::INFO)
puts arg
end
end

require 'ticker/battle_handler/battle_summary'
sum = Ticker::BattleHandler::BattleSummary.new(Military::Battle.find(4))
sum.send_battle_report_messages

#sum = Ticker::BattleHandler::BattleSummary.new(Military::Battle.find(1))

#sum.character_army_summaries.each do |character_id, army_summaries|
#	puts sum.generate_message(Fundamental::Character.find_by_id(character_id))
#end
