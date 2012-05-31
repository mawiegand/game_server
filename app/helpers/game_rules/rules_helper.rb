module GameRules::RulesHelper
  
  # Parses a formula givin in the rules.
  def parse_formula(xml_formula)
    functions = {
      'MIN' => 'min',
      'MAX' => 'max',
      'ROUND' => 'Float.round',
      'CEIL' => 'Float.ceil',
      'FLOOR' => 'Float.floor',
      'POW' => 'power',
      'SIGN' => 'sign',
    }
    
    functions.each do |k, v|      
      xml_formula.gsub!(/#{k}/, v)
    end
    
    xml_formula.gsub!(/LEVEL/, 'level')
    xml_formula
  end
  
  # Evaluates a parsed formular with a given level
  def eval_formula(formula, level)
    eval(formula)
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
