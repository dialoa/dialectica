require "application_system_test_case"

class BibtexEntriesTest < ApplicationSystemTestCase
  setup do
    @bibtex_entry = bibtex_entries(:one)
  end

  test "visiting the index" do
    visit bibtex_entries_url
    assert_selector "h1", text: "Bibtex Entries"
  end

  test "creating a Bibtex entry" do
    visit bibtex_entries_url
    click_on "New Bibtex Entry"

    fill_in "Content", with: @bibtex_entry.content
    click_on "Create Bibtex entry"

    assert_text "Bibtex entry was successfully created"
    click_on "Back"
  end

  test "updating a Bibtex entry" do
    visit bibtex_entries_url
    click_on "Edit", match: :first

    fill_in "Content", with: @bibtex_entry.content
    click_on "Update Bibtex entry"

    assert_text "Bibtex entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Bibtex entry" do
    visit bibtex_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bibtex entry was successfully destroyed"
  end
end
