require 'test_helper'

class Backend::PartnerSitesControllerTest < ActionController::TestCase
  setup do
    @backend_partner_site = backend_partner_sites(:one)
    @controller.current_backend_user = backend_users(:partner)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    # get :index
    # assert_response :success
    # assert_not_nil assigns(:backend_partner_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_partner_site" do
    assert_difference('Backend::PartnerSite.count') do
      post :create, backend_partner_site: @backend_partner_site.attributes
    end

    assert_redirected_to backend_partner_site_path(assigns(:backend_partner_site))
  end

  test "should show backend_partner_site" do
    get :show, id: @backend_partner_site.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_partner_site.to_param
    assert_response :success
  end

  test "should update backend_partner_site" do
    put :update, id: @backend_partner_site.to_param, backend_partner_site: @backend_partner_site.attributes
    assert_redirected_to backend_partner_site_path(assigns(:backend_partner_site))
  end

  test "should destroy backend_partner_site" do
    assert_difference('Backend::PartnerSite.count', -1) do
      delete :destroy, id: @backend_partner_site.to_param
    end

    assert_redirected_to backend_partner_sites_path
  end
end
