require "application_system_test_case"

class ExternalRefereesTest < ApplicationSystemTestCase
  setup do
    @external_referee = external_referees(:one)
  end

  test "visiting the index" do
    visit external_referees_url
    assert_selector "h1", text: "External Referees"
  end

  test "creating a External referee" do
    visit external_referees_url
    click_on "New External Referee"

    fill_in "Email", with: @external_referee.email
    fill_in "Firstname", with: @external_referee.firstname
    fill_in "Lastname", with: @external_referee.lastname
    click_on "Create External referee"

    assert_text "External referee was successfully created"
    click_on "Back"
  end

  test "updating a External referee" do
    visit external_referees_url
    click_on "Edit", match: :first

    fill_in "Email", with: @external_referee.email
    fill_in "Firstname", with: @external_referee.firstname
    fill_in "Lastname", with: @external_referee.lastname
    click_on "Update External referee"

    assert_text "External referee was successfully updated"
    click_on "Back"
  end

  test "destroying a External referee" do
    visit external_referees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "External referee was successfully destroyed"
  end
end
