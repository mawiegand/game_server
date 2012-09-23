require 'test_helper'

class Fundamental::CharacterTest < ActiveSupport::TestCase
  
  fixtures 'military/armies'

  test "can name character" do
    character = Fundamental::Character.new({
      name: "name1",
    })
    assert character.save
    assert_equal character.name, 'name1'
  end

  test "can change character name once" do
    character = Fundamental::Character.new({
      name: "name1",
    })
    assert character.save
    assert_equal character.name, 'name1'
    assert character.name_change_count.nil? || character.name_change_count == 0
    
    character.change_name_transaction('name2')
    assert_equal character.name, 'name2'
    assert character.name_change_count == 1
  end

  test "enforces unique character names" do
    character = Fundamental::Character.new({
      name: "name1",
    })
    assert character.save
    assert_equal character.name, 'name1'

    assert_raise(ConflictError) do
      character.change_name_transaction('Owner')
    end
    assert_equal character.name, 'name1'
    assert character.name_change_count.nil? || character.name_change_count == 0
  end
  
  test "accumulates experience from armies" do
    army  = military_armies(:one)
    owner = army.owner
    assert_not_nil owner
     
    assert_difference(lambda { (owner.exp || 0) }, 50) do  # here, experience may be nil
      army.exp = (army.exp || 0) + 50
      army.save
    end
    
    assert_difference(lambda { owner.exp }, 70) do
      army.exp = (army.exp || 0) + 70
      army.save
    end    
        
  end

end
