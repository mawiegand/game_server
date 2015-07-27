class Fundamental::Treasure < ActiveRecord::Base

  belongs_to :specific_character, :class_name => "Fundamental::Character", :foreign_key => "specific_character_id",    :inverse_of => :poacher_treasures

  belongs_to :location,           :class_name => "Map::Location",          :foreign_key => "location_id",              :inverse_of => :treasures
  belongs_to :region,             :class_name => "Map::Region",            :foreign_key => "region_id",                :inverse_of => :treasures

  belongs_to :army,               :class_name => "Military::Army",         :foreign_key => "army_id",                  :inverse_of => :treasure


  def self.create_for_poacher(poacher)
    return if poacher.nil? || !poacher.is_poacher?

    resource_pool = poacher.specific_character.resource_pool

    return if resource_pool.nil?

    resource_fur_reward = Random.rand((GAME_SERVER_CONFIG['poacher_treasure_min_fur_reward'] || 0.05)..(GAME_SERVER_CONFIG['poacher_treasure_max_fur_reward'] || 0.15)) * resource_pool.resource_fur_capacity
    resource_stone_reward = resource_fur_reward / 2
    resource_wood_reward = resource_fur_reward / 2
    resource_cash_reward = (Random.rand(1.0) <= (GAME_SERVER_CONFIG['poacher_treasure_cash_probability'] || 0.05))? 1 : 0

    treasure = Fundamental::Treasure.new({
      specific_character: poacher.specific_character,
      location: poacher.location,
      region: poacher.region,
      army: poacher,
      resource_stone_reward: resource_stone_reward,
      resource_wood_reward: resource_wood_reward,
      resource_fur_reward: resource_fur_reward,
      resource_cash_reward: resource_cash_reward,
    })

    treasure if treasure.save
  end

  def redeem_rewards
    raise BadRequestError('specific character is not allowed to be empty!') if self.specific_character.nil?

    resource_pool = self.specific_character.resource_pool

    raise BadRequestError("specific character with id #{self.specific_character.id} has no resource_pool!") if resource_pool.nil?

    rewards = { :resource_rewards => [ {:amount => self.resource_stone_reward, :resource => 'resource_stone'},
                                       {:amount => self.resource_wood_reward, :resource => 'resource_wood'},
                                       {:amount => self.resource_fur_reward, :resource => 'resource_fur'},
                                       {:amount => self.resource_cash_reward, :resource => 'resource_cash'},
    ]}
    raise BadRequestError.new('no rewards found in for retention bonus') if rewards.nil?
    resource_rewards = rewards[:resource_rewards]

    # calc resources
    resources = {}
    unless resource_rewards.nil?
      resource_rewards.each do |resource_reward|
        raise BadRequestError.new('no resource_reward given') if resource_reward.nil?

        amount = resource_reward[:amount]
        raise BadRequestError.new('no amount given') if amount.nil?
        raise BadRequestError.new('amount is negative') if amount < 0

        resource_symbolic_id = resource_reward[:resource]
        raise BadRequestError.new('no resource id given') if resource_symbolic_id.nil?

        resource_type = nil
        GameRules::Rules.the_rules().resource_types.each do |type|
          logger.debug "grant_resources: #{type[:symbolic_id]} #{resource_symbolic_id}"
          if type[:symbolic_id].to_s == resource_symbolic_id.to_s
            resource_type = type
            break
          end
        end
        raise BadRequestError.new("no resource type found for resource symbolic id #{resource_symbolic_id}") if resource_type.nil?

        resources[resource_type[:id]] = (resources[resource_type[:id]] || 0) + amount
      end
    end

    # reward resources
    resource_pool.add_resources_transaction(resources)
  end
end
