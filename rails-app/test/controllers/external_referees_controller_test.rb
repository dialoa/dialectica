require 'test_helper'

class ExternalRefereesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @external_referee = external_referees(:one)
  end

  test "should get index" do
    get external_referees_url
    assert_response :success
  end

  test "should get new" do
    get new_external_referee_url
    assert_response :success
  end

  test "should create external_referee" do
    assert_difference('ExternalReferee.count') do
      post external_referees_url, params: { external_referee: { email: @external_referee.email, firstname: @external_referee.firstname, lastname: @external_referee.lastname } }
    end

    assert_redirected_to external_referee_url(ExternalReferee.last)
  end

  test "should show external_referee" do
    get external_referee_url(@external_referee)
    assert_response :success
  end

  test "should get edit" do
    get edit_external_referee_url(@external_referee)
    assert_response :success
  end

  test "should update external_referee" do
    patch external_referee_url(@external_referee), params: { external_referee: { email: @external_referee.email, firstname: @external_referee.firstname, lastname: @external_referee.lastname } }
    assert_redirected_to external_referee_url(@external_referee)
  end

  test "should destroy external_referee" do
    assert_difference('ExternalReferee.count', -1) do
      delete external_referee_url(@external_referee)
    end

    assert_redirected_to external_referees_url
  end
end
