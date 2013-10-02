#!/usr/bin/env ruby

lines = []

filename     = "locations_raw.csv"
lines << File.open(filename).readlines

lines[0].each do |line|
  ip, lat, long = line.strip.split("; ")
  puts "#{lat},#{long}"
end



