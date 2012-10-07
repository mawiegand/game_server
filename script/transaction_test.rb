#!/usr/bin/env ruby
#
# Helper script that runs all consistency checks and repairs inconsistencies
# on the fly.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

use_id = 1

STDOUT.sync = true

pool = Fundamental::ResourcePool.find(use_id)

begin

  pool.resource_wood_amount = 40
  pool.save
  puts "Wood in pool: #{pool.resource_wood_amount}"

  (1..10).each do |i|
    Thread.new do
      retval = pool.remove_resources_transaction({ 1 => 10 })
      puts "No row was affected."   if !retval 
    end
  end
  
  sleep 2
  puts "Wood in pool: #{pool.reload.resource_wood_amount}"  
  
end while pool.reload.resource_wood_amount >= 0 

exit

begin

  pool.resource_wood_amount = 40
  pool.save
  puts "Wood in pool: #{pool.resource_wood_amount}"

  (1..10).each do |i|
    Thread.new do
      if Fundamental::ResourcePool.find(1).resource_wood_amount - 10 >= 0
        retval = Fundamental::ResourcePool.update_all(["resource_wood_amount = resource_wood_amount - ?", 10], ["id = ? AND resource_wood_amount >= ?", pool.id, 10])
        puts "This call would have failed. No row was affected."   if retval == 0
      elsif Fundamental::ResourcePool.find(1).resource_wood_amount == 0
        Fundamental::ResourcePool.update_all(["resource_wood_amount = resource_wood_amount + ?", 10], id: pool.id)        
      end
    end
  end
  
  sleep 2
  
end while pool.reload.resource_wood_amount >= 0 


puts "Wood in pool: #{pool.reload.resource_wood_amount}"