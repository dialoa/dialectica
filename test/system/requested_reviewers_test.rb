require "application_system_test_case"

class RequestedReviewersTest < ApplicationSystemTestCase
  setup do
    @requested_reviewer = requested_reviewers(:one)
  end

  test "visiting the index" do
    visit requested_reviewers_url
    assert_selector "h1", text: "Requested Reviewers"
  end

  test "creating a Requested reviewer" do
    visit requested_reviewers_url
    click_on "New Requested Reviewer"

    fill_in "Email", with: @requested_reviewer.email
    fill_in "Firstname", with: @requested_reviewer.firstname
    fill_in "Lastname", with: @requested_reviewer.lastname
    fill_in "Status", with: @requested_reviewer.status
    click_on "Create Requested reviewer"

    assert_text "Requested reviewer was successfully created"
    click_on "Back"
  end

  test "updating a Requested reviewer" do
    visit requested_reviewers_url
    click_on "Edit", match: :first

    fill_in "Email", with: @requested_reviewer.email
    fill_in "Firstname", with: @requested_reviewer.firstname
    fill_in "Lastname", with: @requested_reviewer.lastname
    fill_in "Status", with: @requested_reviewer.status
    click_on "Update Requested reviewer"

    assert_text "Requested reviewer was successfully updated"
    click_on "Back"
  end

  test "destroying a Requested reviewer" do
    visit requested_reviewers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Requested reviewer was successfully destroyed"
  end
end
