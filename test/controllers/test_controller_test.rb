require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy_all_submissions" do
    get test_destroy_all_submissions_url
    assert_response :success
  end

  test "should get destroy_all_users" do
    get test_destroy_all_users_url
    assert_response :success
  end

  test "should get destroy_all_external_referees" do
    get test_destroy_all_external_referees_url
    assert_response :success
  end

end
