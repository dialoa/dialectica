require 'test_helper'

class BlockedUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blocked_user = blocked_users(:one)
  end

  test "should get index" do
    get blocked_users_url
    assert_response :success
  end

  test "should get new" do
    get new_blocked_user_url
    assert_response :success
  end

  test "should create blocked_user" do
    assert_difference('BlockedUser.count') do
      post blocked_users_url, params: { blocked_user: {  } }
    end

    assert_redirected_to blocked_user_url(BlockedUser.last)
  end

  test "should show blocked_user" do
    get blocked_user_url(@blocked_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_blocked_user_url(@blocked_user)
    assert_response :success
  end

  test "should update blocked_user" do
    patch blocked_user_url(@blocked_user), params: { blocked_user: {  } }
    assert_redirected_to blocked_user_url(@blocked_user)
  end

  test "should destroy blocked_user" do
    assert_difference('BlockedUser.count', -1) do
      delete blocked_user_url(@blocked_user)
    end

    assert_redirected_to blocked_users_url
  end
end
