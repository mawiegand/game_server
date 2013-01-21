#!/usr/bin/env ruby
#
# Helper script that runs all consistency checks and repairs inconsistencies
# on the fly.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

STDOUT.sync = true


def list_successors(quest, depth)
  
  tutorial = Tutorial::Tutorial.the_tutorial
  (1..depth).each do
    print ' '
  end
  
  output = quest[:id].to_s + ' ' + quest[:symbolic_id].to_s
  output += ' *' if quest[:tutorial]
  output += '**' if quest[:tutorial_end_quest]
  puts output
  
  unless quest[:successor_quests].nil?
    quest[:successor_quests].each do |id|
      list_successors(tutorial.quests[id], depth + 2)
    end
  end
end

tutorial = Tutorial::Tutorial.the_tutorial
list_successors(tutorial.quests[0], 0)
