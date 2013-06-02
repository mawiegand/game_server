module GameState
  class Avatars
    # avatar_string structure
    #   0   => gender (m/f)
    #   1   => chain
    #   2   => eyes
    #   3-4 => hair
    #   5   => mouth
    #   6   => head
    #   7-8 => beard
    #   9   => veilchen
    #   10  => tattoo
    attr_accessor :avatar_string

    # TODO: add a setter method for avatar_string to
    #       check if the string has a proper length
    #       according to the AvatarConfig rules

    def gender
      #TODO add check if char is 'm' or 'f' and if necessary
      #     throw an exception
      @avatar_string[0].downcase
    end

    def chain
      @avatar_string[1]
    end

    def eyes
      @avatar_string[2]
    end

    def hair
      @avatar_string[3..4]
    end

    def mouth
      @avatar_string[5]
    end

    def head
      @avatar_string[6]
    end

    def beard
      @avatar_string[7..8]
    end

    def veilchen
      @avatar_string[9]
    end

    def tattoo
      @avatar_string[10]
    end

    def create_random_avatar_string(is_male)
      @avatar_string  = is_male ? 'm' : 'f'

      if(is_male)
        @avatar_string += '0' #chains
        @avatar_string += rand(7).to_s # eyes
        @avatar_string += rand(7).to_s # hair
        @avatar_string += rand(3).to_s # mouth
        @avatar_string += '0' #head
        #beard
        random_number = rand(11)
        @avatar_string += '0' if(random_number < 10)
        @avatar_string += random_number.to_s

        @avatar_string += rand(7).to_s #veilchen
        @avatar_string += rand(7).to_s #tattoos
      else
        @avatar_string += rand(4).to_s #chains
        @avatar_string += rand(7).to_s # eyes
        #hair
        random_number = rand(11)
        @avatar_string += '0' if(random_number < 10)
        @avatar_string += random_number.to_s

        @avatar_string += rand(7).to_s # mouth
        @avatar_string += '0' #head
        @avatar_string += '0' #beard
        @avatar_string += '0' #veilchen
        @avatar_string += rand(7).to_s #tattoos
      end
    end
  end
end
