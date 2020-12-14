require "application_system_test_case"

class ExternalRefereeSubmissionsTest < ApplicationSystemTestCase
  setup do
    @external_referee_submission = external_referee_submissions(:one)
  end

  test "visiting the index" do
    visit external_referee_submissions_url
    assert_selector "h1", text: "External Referee Submissions"
  end

  test "creating a External referee submission" do
    visit external_referee_submissions_url
    click_on "New External Referee Submission"

    click_on "Create External referee submission"

    assert_text "External referee submission was successfully created"
    click_on "Back"
  end

  test "updating a External referee submission" do
    visit external_referee_submissions_url
    click_on "Edit", match: :first

    click_on "Update External referee submission"

    assert_text "External referee submission was successfully updated"
    click_on "Back"
  end

  test "destroying a External referee submission" do
    visit external_referee_submissions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "External referee submission was successfully destroyed"
  end
end
