require 'test_helper'

class RequestedReviewersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requested_reviewer = requested_reviewers(:one)
  end

  test "should get index" do
    get requested_reviewers_url
    assert_response :success
  end

  test "should get new" do
    get new_requested_reviewer_url
    assert_response :success
  end

  test "should create requested_reviewer" do
    assert_difference('RequestedReviewer.count') do
      post requested_reviewers_url, params: { requested_reviewer: { email: @requested_reviewer.email, firstname: @requested_reviewer.firstname, lastname: @requested_reviewer.lastname, status: @requested_reviewer.status } }
    end

    assert_redirected_to requested_reviewer_url(RequestedReviewer.last)
  end

  test "should show requested_reviewer" do
    get requested_reviewer_url(@requested_reviewer)
    assert_response :success
  end

  test "should get edit" do
    get edit_requested_reviewer_url(@requested_reviewer)
    assert_response :success
  end

  test "should update requested_reviewer" do
    patch requested_reviewer_url(@requested_reviewer), params: { requested_reviewer: { email: @requested_reviewer.email, firstname: @requested_reviewer.firstname, lastname: @requested_reviewer.lastname, status: @requested_reviewer.status } }
    assert_redirected_to requested_reviewer_url(@requested_reviewer)
  end

  test "should destroy requested_reviewer" do
    assert_difference('RequestedReviewer.count', -1) do
      delete requested_reviewer_url(@requested_reviewer)
    end

    assert_redirected_to requested_reviewers_url
  end
end
