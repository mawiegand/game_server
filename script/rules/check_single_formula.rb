#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'util/formula'


formula = '10+LEVEL*0.25'


parsed_formula = Util::Formula.parse_from_formula(formula)

for level in 1..20
  puts "#{level} #{parsed_formula.apply(level)}"
end