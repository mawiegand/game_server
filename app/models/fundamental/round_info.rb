require 'identity_provider/access'

class Fundamental::RoundInfo < ActiveRecord::Base

  belongs_to  :winner_alliance, :class_name => 'Fundamental::Alliance', :foreign_key => 'winner_alliance_id'

  # TODO after_save handler fuer eingetragenen sieg
  
  def self.the_round_info
    Fundamental::RoundInfo.find(1)  
  end
  
  def victory_gained?
    !self.winner_alliance.nil?
  end
  
  # return age of round in full days (integer)
  def age
    ((Time.now - self.started_at)/(3600*24)).to_i
  end

  def set_victory_gained(progress, victory_time)
    self.winner_alliance = progress.alliance
    self.winner_alliance_tag = progress.alliance.tag
    self.victory_gained_at = victory_time
    self.victory_type = progress.type_id
    self.save

    winner_identifiers = progress.alliance.members.map { |member| member.identifier }

    # transfer history events for all alliance members to identity provider
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })

    event = {
      type:       "won_round",
      round:      self.number,
      round_name: self.name,
    }
    description = {
      de_DE: "Die Runde #{self.number}, '#{self.name}', gewonnen.",
      en_US: "Won round #{self.number}, '#{self.name}'.",
    }
    identity_provider_access.post_winner_alliance_history_event(winner_identifiers, event, description)

    property = {
      start_resource_bonus: [{resource_type_id: 3, amount: 10}]
    }
    identity_provider_access.post_winner_alliance_character_property(winner_identifiers, property)
  end
end
