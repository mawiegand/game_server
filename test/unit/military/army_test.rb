require 'test_helper'

class Military::ArmyTest < ActiveSupport::TestCase

  test "experience update can handle nil" do
    army = Military::Army.find(1)
    army.exp = nil
    assert army.save
    assert_not_nil army.owner
    
    army.exp = 1
    army.send :update_experience_character
    assert_equal 1, army.exp
  end
end
