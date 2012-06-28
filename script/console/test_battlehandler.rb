require 'ticker/command'
require 'ticker/runloop'
class DummyRunloop
def say(arg, level = Logger::INFO)
puts arg
end
end
bh = Ticker::BattleHandler.new
bh.runloop = DummyRunloop.new
bh.process_event(Event::Event.find_by_id(5))
