module Util

  def self.make_random_string(len = 64, lower_case = false)
    chars = ('a'..'z').to_a 
    chars += ('A'..'Z').to_a unless lower_case
    (0..(len-1)).collect { chars[Kernel.rand(chars.length)] }.join
  end
      
end