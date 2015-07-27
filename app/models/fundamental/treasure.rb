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
end
