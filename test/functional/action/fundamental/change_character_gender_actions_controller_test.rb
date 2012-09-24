require 'test_helper'

class Action::Fundamental::ChangeCharacterGenderActionsControllerTest < ActionController::TestCase

  setup do
    @character = fundamental_characters(:owner)
  end
  
  
  # ##########################################################################
  #
  #   API SPECIFIC TESTS 
  #
  # ##########################################################################

  test "could change gender via API access at least once" do
    assert_not_nil @character
    assert @character.male?

    @controller.current_character = @character

    post :create, character: { gender: 'female' }, format: "json"
    assert_response :ok
    
    @character.reload
    assert @character.female? 
  end

  test "could not change gender without current_character via API access" do
    post :create, character: { gender: 'female' }, format: "json"
    assert_response :unauthorized
  end  
  
  # ##########################################################################
  #
  #   BACKEND TESTS AND GENERAL FUNCTIONAL TESTS
  #
  # ##########################################################################
  
  # presently, the controller offers no backend functionallity
  
end
