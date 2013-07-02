#!/usr/bin/env ruby
#
# Export all characters with distinct trade partners according to the second community events as csv
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script exports all characters with distinct trade partners according to the second community events."

trades = Backend::TradeLogEntry.where('? < created_at and created_at < ? and resource_stone_amount + resource_wood_amount + resource_fur_amount >= 1000', DateTime.new(2013, 6, 24).advance(:hours => 12), DateTime.new(2013, 7, 1).advance(:hours => 12))

trader = []

trades.each do |trade1|
  trades.each do |trade2|
    if trade1.sender_id == trade2.recipient_id && trade2.sender_id == trade1.recipient_id
      if trader[trade1.sender_id].nil?
	trader[trade1.sender_id] = []
      end
      if trader[trade1.sender_id][trade1.recipient_id].nil?
        trader[trade1.sender_id][trade1.recipient_id] = 0
      end
      trader[trade1.sender_id][trade1.recipient_id] += 1
    end
  end
end

output_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'trade_master.csv'))

File.open(output_filename, 'w') do |out|
  out.write("\"character_id\";\"trades\"\n")
  (0..trader.length).each do |i|
    unless trader[i].nil?
      count = 0
      trader[i].each do |t|
        unless t.nil?
          count += 1
        end
      end
      out.write("#{i};#{count}\n")
    end
  end
end

puts "Done."
