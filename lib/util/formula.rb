module Util
  class Formula
    # Parses a formula givin in the rules.
    def self.parse_from_formula(formula)
      Util::Formula.new(formula)
    end
    
    def initialize(formula)
      functions = {
        'MIN'     => 'min',
        'MAX'     => 'max',
        'ROUND'   => 'round',
        'CEIL'    => 'ceil',
        'FLOOR'   => 'floor',
        'POW'     => 'power',
        'SIGN'    => 'sign',
        'EQUAL'   => 'equal',
        'LESS'    => 'less',
        'GREATER' => 'greater',
        'NOT'     => 'not',
        'AND'     => 'and',
      }
      
      
      @formula = String.new(formula) || "0"   # nil evaluates to 0; good idea?

      functions.each do |k, v|
        @formula.gsub!(/#{k}/, v)
      end

      @formula.gsub!(/LEVEL/, 'level')
    end

    # Evaluates a parsed formular with a given level
    def apply(level = nil)
      level == nil || level == 0 ? 0 : eval(@formula)
    end
    
    
    def difference(old_level, new_level)
      old_value = apply(old_level)
      new_value = apply(new_level)
      new_value-old_value
    end
      
    protected
    
      def floor(n) 
        n.floor
      end
    
      def ceil(n)
        n.ceil
      end
    
      def round(n)
        n.round
      end

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
      
      def equal(a, b)
        a == b ? 1 : 0
      end
      
      def less(a, b)
        a < b ? 1 : 0
      end
      
      def greater(a, b)
        a > b ? 1 : 0
      end
      
      def not(a)
        a == 0 ? 1 : 0
      end
      
      def and(a,b)
        not(a) == 0 && not(b) == 0 ? 1 : 0
      end
      
      def or(a,b) 
        not(a) == 0 || not(b) == 0 ? 1 : 0
      end

  end
end