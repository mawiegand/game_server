module GameState
  
  class Rewards
    
    def self.resource_hash_from_rewards(resource_rewards)
      resources = {}
      unless resource_rewards.nil?
        resource_rewards.each do |resource_reward|
          raise BadRequestError.new('no resource_reward given') if resource_reward.nil?

          raise BadRequestError.new('no amount given') if resource_reward[:amount].nil?
          amount = (resource_reward[:amount] || 0).to_f
          raise BadRequestError.new('amount is negative') if amount < 0

          resource_symbolic_id = resource_reward[:resource]
          raise BadRequestError.new('no resource id given') if resource_symbolic_id.nil?

          resource_type = nil
          GameRules::Rules.the_rules().resource_types.each do |type|
            # Rails.logger.debug "grant_resources: #{type[:symbolic_id]} #{resource_symbolic_id}" 
            if type[:symbolic_id].to_s == resource_symbolic_id.to_s
              resource_type = type
              break
            end
          end
          raise BadRequestError.new("no resource type found for resource symbolic id #{resource_symbolic_id}") if resource_type.nil?

          resources[resource_type[:id]] = (resources[resource_type[:id]] || 0) + amount
        end
      end
      resources
    end

    def self.unit_hash_from_rewards(unit_rewards)
      units = {}
      total_unit_amount = 0
      unless unit_rewards.nil?
        unit_rewards.each do |unit_reward|
          raise BadRequestError.new('no unit_reward given') if unit_reward.nil?

          raise BadRequestError.new('no amount given') if unit_reward[:amount].nil?
          amount = (unit_reward[:amount] || 0).to_i
          raise BadRequestError.new('amount is negative') if amount < 0

          unit_db_field = unit_reward[:unit]
          raise BadRequestError.new('no unit id given') if unit_db_field.nil?

          units[unit_db_field] = amount
          total_unit_amount += amount
        end
      end
      units
    end

  end
end