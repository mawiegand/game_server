#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'util/formula'


formula = 'LESS(LEVEL,11)*(10+LEVEL)+GREATER(LEVEL,10)*20'


parsed_formula = Util::Formula.parse_from_formula(formula)

for level in 1..20
  puts "#{level} #{parsed_formula.apply(level)}"
end