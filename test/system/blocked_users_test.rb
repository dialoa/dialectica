require "application_system_test_case"

class BlockedUsersTest < ApplicationSystemTestCase
  setup do
    @blocked_user = blocked_users(:one)
  end

  test "visiting the index" do
    visit blocked_users_url
    assert_selector "h1", text: "Blocked Users"
  end

  test "creating a Blocked user" do
    visit blocked_users_url
    click_on "New Blocked User"

    click_on "Create Blocked user"

    assert_text "Blocked user was successfully created"
    click_on "Back"
  end

  test "updating a Blocked user" do
    visit blocked_users_url
    click_on "Edit", match: :first

    click_on "Update Blocked user"

    assert_text "Blocked user was successfully updated"
    click_on "Back"
  end

  test "destroying a Blocked user" do
    visit blocked_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blocked user was successfully destroyed"
  end
end
