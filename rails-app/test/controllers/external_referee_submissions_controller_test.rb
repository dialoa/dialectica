require 'test_helper'

class ExternalRefereeSubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @external_referee_submission = external_referee_submissions(:one)
  end

  test "should get index" do
    get external_referee_submissions_url
    assert_response :success
  end

  test "should get new" do
    get new_external_referee_submission_url
    assert_response :success
  end

  test "should create external_referee_submission" do
    assert_difference('ExternalRefereeSubmission.count') do
      post external_referee_submissions_url, params: { external_referee_submission: {  } }
    end

    assert_redirected_to external_referee_submission_url(ExternalRefereeSubmission.last)
  end

  test "should show external_referee_submission" do
    get external_referee_submission_url(@external_referee_submission)
    assert_response :success
  end

  test "should get edit" do
    get edit_external_referee_submission_url(@external_referee_submission)
    assert_response :success
  end

  test "should update external_referee_submission" do
    patch external_referee_submission_url(@external_referee_submission), params: { external_referee_submission: {  } }
    assert_redirected_to external_referee_submission_url(@external_referee_submission)
  end

  test "should destroy external_referee_submission" do
    assert_difference('ExternalRefereeSubmission.count', -1) do
      delete external_referee_submission_url(@external_referee_submission)
    end

    assert_redirected_to external_referee_submissions_url
  end
end
