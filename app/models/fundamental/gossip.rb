class Fundamental::Gossip < ActiveRecord::Base
  
  serialize  :content
  
  scope :newest_first, order('created_at DESC')
  
  after_find   :update_if_expired
  before_save  :add_expiration
  
  def self.create_new_random_advice
    Fundamental::Gossip.create({
      content_type: :random_advice,
      content: { number: rand(999999) },
    })
  end
  
  def self.find_or_create
    gossip = Fundamental::Gossip.newest_first.first
    if gossip.nil?
      gossip = Fundamental::Gossip.create_new_random_advice
    end
    gossip
  end
  
  def update_with_random_gossip
    if rand(100) < 50
      calc_random_advice
    else
      option = gossip_options.sample
      self.send(option)
    end
  end
  
  def self.check_and_repair_consistency
    if Fundamental::Gossip.count > 1
      Fundamental::Gossip.newest_first.limit(5).offset(1).each do |gossip|
        gossip.destroy
      end
    end
    true
  end
  
  # /////////////////////////////////////////////////////////////////////////
  #
  #   GOSSIP FUNCTIONS
  #
  # /////////////////////////////////////////////////////////////////////////
  
  def gossip_options
    @gossip_options ||= [
      :calc_resource_type_production_leader,
      :calc_most_liked_player,
      :calc_most_messages_sent,
    ]
  end
  
  def calc_random_advice
    self.content_type = :random_advice
    self.content = { number: rand(999999) }
  end
  
  def calc_resource_type_production_leader
    options = []
    GameRules::Rules.the_rules().resource_types.each do |resource|
      options.push(resource[:id])  if resource[:tradable]
    end
    resource_type = GameRules::Rules.the_rules().resource_types[options.sample]
    base          = resource_type[:symbolic_id].to_s
    production    = base+'_production_rate'
    pool = Fundamental::ResourcePool.order("#{production} DESC").limit(1).first
    self.content_type = :resource_type_production_leader
    self.content = {
      resource_id: resource_type[:id],
      character_id: pool.owner.id,
      male: pool.owner.male?,
      name: pool.owner.name,
      rate: pool[production],
    }
  end
  
  def calc_most_liked_player
    character = Fundamental::Character.non_npc.order('received_likes_count DESC').limit(1).first
    self.content_type = :most_liked_player
    self.content = {
      character_id: character.id,
      name: character.name,
      male: character.male?,
      likes: character.received_likes_count,
    }
  end
  
  def calc_most_messages_sent
    results   = Messaging::OutboxEntry.where(['created_at > ?', DateTime.now-1.weeks]).group(:owner_id).count
    max_value = results.values.max
    max_entry = results.select {|k,v| v == max_value}
    
    return  if max_entry.nil?
    
    character = Fundamental::Character.find_by_id(max_entry.keys.first)
    
    return  if character.nil?
    
    self.content_type = :most_messages_sent
    self.content = {
      character_id: character.id,
      name: character.name,
      male: character.male?,
      messages: max_value,
    }
  end
  
  def calc_most_units
    results   = Military::Army.group(:owner_id).sum(:size_present)
    Fundamental::Character.npc.each do |character|
      results.delete(character.id)
    end
    
    max_value = results.values.max
    max_entry = results.select {|k,v| v == max_value}
    
    return  if max_entry.nil?
    
    character = Fundamental::Character.find_by_id(max_entry.keys.first)
    
    return  if character.nil?
    
    self.content_type = :most_units
    self.content = {
      character_id: character.id,
      name: character.name,
      male: character.male?,
      units: max_value,
    }
  end  
  
  protected
  
    def update_if_expired
      if self.ended_at.nil? || (self.ended_at < DateTime.now && rand(50) < 1)
        self.update_with_random_gossip
        self.save
        
        Fundamental::Gossip.check_and_repair_consistency
      end
      true
    end
    
    def add_expiration
      self.ended_at = DateTime.now + 1.hours
      true
    end
  
end
