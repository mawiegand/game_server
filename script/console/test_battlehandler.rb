require 'ticker/command'
require 'ticker/runloop'
class DummyRunloop
def say(arg, level = Logger::INFO)
puts arg
end
end
bh = Ticker::BattleHandler.new
bh.runloop = DummyRunloop.new
bh.process_event(Event::Event.last)


mh = Ticker::MovementHandler.new
mh.runloop = DummyRunloop.new
mh.process_event(Event::Event.last)