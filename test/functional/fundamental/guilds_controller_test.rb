require 'test_helper'

class Fundamental::GuildsControllerTest < ActionController::TestCase
  setup do
    @fundamental_guild = fundamental_guilds(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_guilds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_guild" do
    assert_difference('Fundamental::Guild.count') do
      post :create, fundamental_guild: @fundamental_guild.attributes
    end

    assert_redirected_to fundamental_guild_path(assigns(:fundamental_guild))
  end

  test "should show fundamental_guild" do
    get :show, id: @fundamental_guild.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_guild.to_param
    assert_response :success
  end

  test "should update fundamental_guild" do
    put :update, id: @fundamental_guild.to_param, fundamental_guild: @fundamental_guild.attributes
    assert_redirected_to fundamental_guild_path(assigns(:fundamental_guild))
  end

  test "should destroy fundamental_guild" do
    assert_difference('Fundamental::Guild.count', -1) do
      delete :destroy, id: @fundamental_guild.to_param
    end

    assert_redirected_to fundamental_guilds_path
  end
end
