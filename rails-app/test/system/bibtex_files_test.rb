require "application_system_test_case"

class BibtexFilesTest < ApplicationSystemTestCase
  setup do
    @bibtex_file = bibtex_files(:one)
  end

  test "visiting the index" do
    visit bibtex_files_url
    assert_selector "h1", text: "Bibtex Files"
  end

  test "creating a Bibtex file" do
    visit bibtex_files_url
    click_on "New Bibtex File"

    fill_in "Content", with: @bibtex_file.content
    click_on "Create Bibtex file"

    assert_text "Bibtex file was successfully created"
    click_on "Back"
  end

  test "updating a Bibtex file" do
    visit bibtex_files_url
    click_on "Edit", match: :first

    fill_in "Content", with: @bibtex_file.content
    click_on "Update Bibtex file"

    assert_text "Bibtex file was successfully updated"
    click_on "Back"
  end

  test "destroying a Bibtex file" do
    visit bibtex_files_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bibtex file was successfully destroyed"
  end
end
