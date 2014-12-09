require 'test_helper'

class RefreshAuditsControllerTest < ActionController::TestCase
  setup do
    @refresh_audit = refresh_audits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:refresh_audits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create refresh_audit" do
    assert_difference('RefreshAudit.count') do
      post :create, refresh_audit: { stamp: @refresh_audit.stamp, type: @refresh_audit.type }
    end

    assert_redirected_to refresh_audit_path(assigns(:refresh_audit))
  end

  test "should show refresh_audit" do
    get :show, id: @refresh_audit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @refresh_audit
    assert_response :success
  end

  test "should update refresh_audit" do
    patch :update, id: @refresh_audit, refresh_audit: { stamp: @refresh_audit.stamp, type: @refresh_audit.type }
    assert_redirected_to refresh_audit_path(assigns(:refresh_audit))
  end

  test "should destroy refresh_audit" do
    assert_difference('RefreshAudit.count', -1) do
      delete :destroy, id: @refresh_audit
    end

    assert_redirected_to refresh_audits_path
  end
end
