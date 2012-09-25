require 'test_helper'

class Settlement::SettlementTest < ActiveSupport::TestCase

  test "can create home base" do
    character = fundamental_characters(:owner)
    location  = map_locations(:one)
    region    = map_regions(:one)
    node      = map_nodes(:one)

    region.node     = node
    location.region = region
    
    settlement = Settlement::Settlement.create_settlement_at_location(location, 2, character)
    assert_not_nil settlement
    assert_equal character, settlement.owner
  end

end
