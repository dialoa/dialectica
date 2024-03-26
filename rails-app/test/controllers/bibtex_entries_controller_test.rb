require 'test_helper'

class BibtexEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bibtex_entry = bibtex_entries(:one)
  end

  test "should get index" do
    get bibtex_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_bibtex_entry_url
    assert_response :success
  end

  test "should create bibtex_entry" do
    assert_difference('BibtexEntry.count') do
      post bibtex_entries_url, params: { bibtex_entry: { content: @bibtex_entry.content } }
    end

    assert_redirected_to bibtex_entry_url(BibtexEntry.last)
  end

  test "should show bibtex_entry" do
    get bibtex_entry_url(@bibtex_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_bibtex_entry_url(@bibtex_entry)
    assert_response :success
  end

  test "should update bibtex_entry" do
    patch bibtex_entry_url(@bibtex_entry), params: { bibtex_entry: { content: @bibtex_entry.content } }
    assert_redirected_to bibtex_entry_url(@bibtex_entry)
  end

  test "should destroy bibtex_entry" do
    assert_difference('BibtexEntry.count', -1) do
      delete bibtex_entry_url(@bibtex_entry)
    end

    assert_redirected_to bibtex_entries_url
  end
end
