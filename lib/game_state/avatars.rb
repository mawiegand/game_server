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
        @avatar_string += random_number :max_chains_male
        @avatar_string += random_number :max_eyes_male
        @avatar_string += random_number :max_hair_male
        @avatar_string += random_number :max_mouths_male
        @avatar_string += random_number :max_heads_male
        @avatar_string += random_number :max_beards_male
        @avatar_string += random_number :max_veilchens_male
        @avatar_string += random_number :max_tattos_male
      else
        @avatar_string += random_number :max_chains_female
        @avatar_string += random_number :max_eyes_female
        @avatar_string += random_number :max_hair_female
        @avatar_string += random_number :max_mouths_female
        @avatar_string += random_number :max_heads_female
        @avatar_string += random_number :max_beards_female
        @avatar_string += random_number :max_veilchens_female
        @avatar_string += random_number :max_tattos_female
      end
    end

    # returns a random number (as string) or '0' according to it's rules
    private
    def random_number(rule)
      value = @rules[rule].to_i
      value >= 10 ? "%02d" % rand(value) : rand(value).to_i.to_s
    end
  end
end
