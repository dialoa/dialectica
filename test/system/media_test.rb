require "application_system_test_case"

class MediaTest < ApplicationSystemTestCase
  setup do
    @medium = media(:one)
  end

  test "visiting the index" do
    visit media_url
    assert_selector "h1", text: "Media"
  end

  test "creating a Medium" do
    visit media_url
    click_on "New Medium"

    fill_in "Comment", with: @medium.comment
    click_on "Create Medium"

    assert_text "Medium was successfully created"
    click_on "Back"
  end

  test "updating a Medium" do
    visit media_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @medium.comment
    click_on "Update Medium"

    assert_text "Medium was successfully updated"
    click_on "Back"
  end

  test "destroying a Medium" do
    visit media_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Medium was successfully destroyed"
  end
end
