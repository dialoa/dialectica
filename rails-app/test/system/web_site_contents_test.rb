require "application_system_test_case"

class WebSiteContentsTest < ApplicationSystemTestCase
  setup do
    @web_site_content = web_site_contents(:one)
  end

  test "visiting the index" do
    visit web_site_contents_url
    assert_selector "h1", text: "Web Site Contents"
  end

  test "creating a Web site content" do
    visit web_site_contents_url
    click_on "New Web Site Content"

    fill_in "Content", with: @web_site_content.content
    fill_in "Identifier", with: @web_site_content.identifier
    fill_in "Title", with: @web_site_content.title
    click_on "Create Web site content"

    assert_text "Web site content was successfully created"
    click_on "Back"
  end

  test "updating a Web site content" do
    visit web_site_contents_url
    click_on "Edit", match: :first

    fill_in "Content", with: @web_site_content.content
    fill_in "Identifier", with: @web_site_content.identifier
    fill_in "Title", with: @web_site_content.title
    click_on "Update Web site content"

    assert_text "Web site content was successfully updated"
    click_on "Back"
  end

  test "destroying a Web site content" do
    visit web_site_contents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Web site content was successfully destroyed"
  end
end
