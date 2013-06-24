module GameState
  class Avatars
    attr_accessor :avatar_string

    def initialize
      @rules = GameRules::Rules.the_rules.avatar_config
    end

    # TODO: add a setter method for avatar_string to
    #       check if the string has a proper length
    #       according to the AvatarConfig rules

    def gender
      #TODO add check if char is 'm' or 'f' and if necessary
      #     throw an exception
      @avatar_string[0].downcase
    end
    
    def rule
      gender == 'm' ? @rules[:male] : @rules[:female]
    end
    
    def value_of_layer(layer)
      start = 0
      i = 1;
      rule.each do |key, entry| 
        if key == layer
          start = i
        end
        i += entry[:num_chars] 
      end      
      rule[layer][:num_chars] == 1 ? avatar_string[start] : avatar_string[start..(start+rule[layer][:num_chars]-1)]
    end
    
    
    def create_random_avatar_string(is_male)
      gender = is_male ? :male : :female
      @avatar_string  = is_male ? 'm' : 'f'
      
      @rules[gender].each do |key, entry| 
        @avatar_string += random_number gender, key        
      end
      @avatar_string
    end
    
    # the following method is only there for migrating existing
    # avatars so that they have the same appearance as in the 
    # ios client at present.
    def create_avatar_string_from_id_and_gender(cid, is_male)
      @avatar_string  = is_male ? 'm' : 'f'
      gender          = is_male ? :male : :female

      entries = if is_male
        {
          :chains    => [0],
          :eyes      => [1,1,1,2,2,2,2,3],
          :hairs     => [1,1,2,3,4,5,0,0],
          :mouths    => [1,2,3,4],
          :heads     => [1],
          :beards    => [1,2,3,4,5,6,0,0,0,0,0,0],
          :veilchens => [1,2,3,4,0,0,0,0],
          :tattoos   => [1,2,3,4,4,0,0,0],
        }
      else
        {
          :chains    => [1,2,0,0],
          :eyes      => [1,1,1,2,3,3,4,4],
          :hairs     => [1,2,3,4,5,6,7,8,9,10,11,0],
          :mouths    => [1,1,1,2,3,3,4,5],
          :heads     => [1],
          :beards    => [0],
          :veilchens => [0],
          :tattoos   => [1,1,2,3,3,0,0,0],
        }        
      end
     
      indices = {  # calculations as done by the ios client
        :heads    => cid,
        :hairs    => (cid*0.5).floor,
        :eyes     => cid,
        :mouths   => cid*3,
        :tattoos  => cid*7,
        :beards   => (cid*0.3).floor,
        :chains   => cid*11,
        :veilchens => (cid*0.17).floor,
      }
      
      @rules[gender].each do |key, entry| 
        n = indices[key] % entries[key].count
        @avatar_string += "%0#{entry[:num_chars].to_s}d" % entries[key][n]     
      end
      @avatar_string      
    end
    
    

    # returns a random number (as string) or '0' according to it's rules
    private
    
      def random_number(gender, rule)
        entry  = @rules[gender][rule]
        number = entry[:optional] ? rand(entry[:max]+1) : rand(entry[:max])+1
        "%0#{entry[:num_chars].to_s}d" % number
      end
      
  end
end
