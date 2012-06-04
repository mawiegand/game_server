module Util
  class Formula
    # Parses a formula givin in the rules.
    def self.parse_from_formula(formula)
      Util::Formula.new(formula)
    end
    
    def initialize(formula)
      functions = {
        'MIN' => 'min',
        'MAX' => 'max',
        'ROUND' => 'Float.round',
        'CEIL' => 'Float.ceil',
        'FLOOR' => 'Float.floor',
        'POW' => 'power',
        'SIGN' => 'sign',
      }
      
      @formula = formula

      functions.each do |k, v|
        @formula.gsub!(/#{k}/, v)
      end

      @formula.gsub!(/LEVEL/, 'level')
    end

    # Evaluates a parsed formular with a given level
    def apply(level)
      eval(@formula)
    end

    protected

    def power(base, exp)
      (base) ** (exp)
    end

    def min(a, b)
      [a, b].min
    end

    def max(a, b)
      [a, b].max
    end

    def sign(a)
      return -1 if a < 0
      return +1 if a > 0
      0
    end

  end
end