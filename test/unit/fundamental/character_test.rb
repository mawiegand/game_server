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
    owner.exp = nil         # test that accumulation also works with nil values
    owner.save
    assert_nil owner.exp
     
    assert_difference(lambda { (owner.exp || 0) }, 50) do  # here, experience may be nil
      army.exp = (army.exp || 0) + 50
      army.save
    end
    
    assert_difference(lambda { owner.exp }, 70) do
      army.exp = (army.exp || 0) + 70
      army.save
    end    
    
    assert_no_difference(lambda { owner.exp}) do
      army.destroy
    end 
  end
  
  
  test "correctly advances mundane ranks and adds skill points" do
    character = Fundamental::Character.find(1)
    character.exp = 0         # test that accumulation also works with nil values
    character.mundane_rank = 0
    character.skill_points = nil
    assert character.save

    ranks = GameRules::Rules.the_rules.character_ranks[:mundane]
    skill_points_per_rank = GameRules::Rules.the_rules.character_ranks[:skill_points_per_mundane_rank]    

    # test with NOT enough exp, but enough sacred rank
    character.exp         = ranks[1][:exp]-1
    character.sacred_rank = ranks[1][:minimum_sacred_rank]+1
  
    assert !character.fulfills_mundane_rank?((character.mundane_rank || 0) +1)
    
    assert_no_difference(lambda { (character.mundane_rank) }) do  
      character.advance_to_next_mundane_rank_if_possible
    end
    assert_no_difference(lambda { (character.mundane_rank) }) do  
      character.update_mundane_rank
    end
    assert_no_difference(lambda { (character.mundane_rank) }) do  
      assert character.save
    end
    assert_difference(lambda { (character.mundane_rank) }, 1) do  
      character.send :advance_to_next_mundane_rank    # bypass protection to test it
    end
    assert_equal skill_points_per_rank, character.skill_points

    character.mundane_rank = 0
    assert character.save
    
    # test with enough exp, but NOT enough sacred rank
    character.exp          = ranks[1][:exp]
    character.sacred_rank  = ranks[1][:minimum_sacred_rank]-1
    character.skill_points = skill_points_per_rank
    
    assert_no_difference(lambda { (character.mundane_rank) }) do  
      assert character.save
    end  

    # test with enough exp, AND enough sacred rank    
    character.sacred_rank += 1
    assert_equal 0, character.mundane_rank
    assert character.fulfills_mundane_rank?((character.mundane_rank || 0) +1)


    assert_difference(lambda { (character.mundane_rank) }, 1) do  
      character.update_mundane_rank
    end     
    character.mundane_rank = 0
    character.skill_points = skill_points_per_rank

    assert_difference(lambda { (character.mundane_rank) }, 1) do  
      assert character.save
    end     
    assert_equal skill_points_per_rank*2, character.skill_points  

  end

end
