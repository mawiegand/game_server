require 'test_helper'

class Fundamental::CharacterTest < ActiveSupport::TestCase

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

end
