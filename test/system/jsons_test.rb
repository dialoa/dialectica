require "application_system_test_case"

class JsonsTest < ApplicationSystemTestCase
  setup do
    @json = jsons(:one)
  end

  test "visiting the index" do
    visit jsons_url
    assert_selector "h1", text: "Jsons"
  end

  test "creating a Json" do
    visit jsons_url
    click_on "New Json"

    fill_in "Content", with: @json.content
    click_on "Create Json"

    assert_text "Json was successfully created"
    click_on "Back"
  end

  test "updating a Json" do
    visit jsons_url
    click_on "Edit", match: :first

    fill_in "Content", with: @json.content
    click_on "Update Json"

    assert_text "Json was successfully updated"
    click_on "Back"
  end

  test "destroying a Json" do
    visit jsons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Json was successfully destroyed"
  end
end
