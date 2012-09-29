require 'test_helper'

class Fundamental::CharacterTest < ActiveSupport::TestCase
  
  fixtures 'military/armies'


  # ##########################################################################
  #
  #   CHARACTER CUSTOMIZATION
  #
  # ##########################################################################  

  test "can name character" do
    character = Fundamental::Character.new({
      name: "name1",
    })
    assert character.save
    assert_equal character.name, 'name1'
  end

  # test "can change character name once" do
    # character = Fundamental::Character.new({
      # name: "name1",
    # })
    # assert character.save
    # assert_equal character.name, 'name1'
    # assert character.name_change_count.nil? || character.name_change_count == 0
#     
    # character.change_name_transaction('name2')
    # character.reload
    # assert_equal character.name, 'name2'
    # assert character.name_change_count == 1
  # end
  
  test "can change character gender once" do
    character = Fundamental::Character.new({
      name: "name1",
      gender: nil,
    })
    assert character.save
    assert character.gender_change_count.nil? || character.gender_change_count == 0
    assert !character.female?
    assert character.male?
    
    character.change_gender_transaction('female')
    character.reload
    assert character.female?
    assert !character.male?

    assert_equal 1, character.gender_change_count
  end

  # test "enforces unique character names" do
    # character = Fundamental::Character.new({
      # name: "name1",
    # })
    # assert character.save
    # assert_equal character.name, 'name1'
# 
    # assert_raise(ConflictError) do
      # character.change_name_transaction('Owner')
    # end
    # assert_equal character.name, 'name1'
    # assert character.name_change_count.nil? || character.name_change_count == 0
  # end
#   
  # ##########################################################################
  #
  #   RANK PROGRESSION AND EXPERIENCE
  #
  # ##########################################################################  
  
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

    assert_difference(lambda { character.settlement_points_total }, ranks[1][:settlement_points]) do
      assert_difference(lambda { character.mundane_rank }, 1) do  
        character.send :advance_to_next_mundane_rank    # bypass protection to test it
      end
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

    assert_difference(lambda { character.settlement_points_total }, ranks[1][:settlement_points]) do
      assert_difference(lambda { (character.mundane_rank) }, 1) do  
        assert character.save
      end
    end     
    assert_equal skill_points_per_rank*2, character.skill_points  

  end
  
  # ##########################################################################
  #
  #   CONSISTENCY CHECK RELATED
  #
  # ##########################################################################

  test "consistency check correctly repairs character" do
    character = Fundamental::Character.find(1)
    ranks = GameRules::Rules.the_rules.character_ranks[:mundane]
    sp_r0 =  ranks[0][:settlement_points] || 0
    sp_r1 = (ranks[1][:settlement_points] || 0) + sp_r0
    
    assert_not_nil character
    sp_used = character.recalc_settlement_points_used
    
    character.exp = 0         
    character.mundane_rank = 1
    character.skill_points = nil
    character.settlement_points_total = 0
    character.settlement_points_used = sp_used + 10
    assert character.save
    
    character.check_consistency
    assert_equal sp_r1,   character.settlement_points_total
    assert_equal sp_used, character.settlement_points_used

    character.mundane_rank = 0
    character.check_consistency
    assert_equal sp_r0, character.settlement_points_total
    
    character.check_consistency
    assert_equal sp_r0, character.settlement_points_total    
  end
  
  # ##########################################################################
  #
  #   SETTLEMENT POINTS RELATED
  #
  # ##########################################################################
  
  test "increment settlement points on home settlement creation" do
    character = fundamental_characters(:owner)
    location  = map_locations(:two)
    region    = map_regions(:one)
    node      = map_nodes(:one)

    region.node     = node
    location.region = region
    character.update_settlement_points_used
    
    assert_difference(lambda { character.settlement_points_used }, 1) do
      settlement = Settlement::Settlement.create_settlement_at_location(location, 2, character)
      assert character.reload
      assert_not_nil settlement
    end
  end


  test "update settlement points correctly on settlement ownership change" do
    character = fundamental_characters(:owner)
    new_owner = fundamental_characters(:ally)
    location  = map_locations(:two)
    region    = map_regions(:one)
    node      = map_nodes(:one)

    region.node     = node
    location.region = region
    new_owner.resource_pool = fundamental_resource_pools(:two)
    
    settlement = Settlement::Settlement.create_settlement_at_location(location, 2, character)
    assert character.reload
    assert_not_nil settlement
    assert_equal character, settlement.owner

    new_owner.update_settlement_points_used
    character.update_settlement_points_used
    
    
    assert_difference(lambda { new_owner.settlement_points_used }, 1) do
      assert_difference(lambda { character.settlement_points_used }, -1) do
        settlement.new_owner_transaction(new_owner)
        assert_equal new_owner, settlement.owner
        
        assert character.reload
        assert new_owner.reload
      end
    end

  end



end
