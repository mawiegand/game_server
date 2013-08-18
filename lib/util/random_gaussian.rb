module Util

  class RandomGaussian
    
    def initialize(mean, stddev, rand_helper = lambda { Kernel.rand })
      @rand_helper = rand_helper
      @mean = mean
      @stddev = stddev
      
      initial = self.class.gaussian(@mean, @stddev, @rand_helper)

      @valid = true
      @next = initial.sample
    end

    def rand
      if @valid then
        @valid = false
        return @next
      else
        @valid = true
        x, y = self.class.gaussian(@mean, @stddev, @rand_helper)
        @next = y
        return x
      end
    end

    private
      def self.gaussian(mean, stddev, rand)
        theta = 2 * Math::PI * rand.call
        rho = Math.sqrt(-2 * Math.log(1 - rand.call))
        scale = stddev * rho
   
        x = mean + scale * Math.cos(theta)
        y = mean + scale * Math.sin(theta)
        return x, y
      end
  end

end