#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'util/formula'

formula = '1600+100*(FLOOR((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(110*POW(LEVEL,2)-105*LEVEL)+(MAX(LEVEL+1,11)-MAX(LEVEL,11))*(20*POW((LEVEL),2)+9000))/100)'

f = Util::Formula.parse_from_formula(formula)
(1..20).each do |l|
  puts f.apply(l)
end
