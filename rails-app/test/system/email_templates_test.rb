require "application_system_test_case"

class EmailTemplatesTest < ApplicationSystemTestCase
  setup do
    @email_template = email_templates(:one)
  end

  test "visiting the index" do
    visit email_templates_url
    assert_selector "h1", text: "Email Templates"
  end

  test "creating a Email template" do
    visit email_templates_url
    click_on "New Email Template"

    fill_in "Content", with: @email_template.content
    click_on "Create Email template"

    assert_text "Email template was successfully created"
    click_on "Back"
  end

  test "updating a Email template" do
    visit email_templates_url
    click_on "Edit", match: :first

    fill_in "Content", with: @email_template.content
    click_on "Update Email template"

    assert_text "Email template was successfully updated"
    click_on "Back"
  end

  test "destroying a Email template" do
    visit email_templates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Email template was successfully destroyed"
  end
end
