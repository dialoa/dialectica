require 'test_helper'

class BibtexFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bibtex_file = bibtex_files(:one)
  end

  test "should get index" do
    get bibtex_files_url
    assert_response :success
  end

  test "should get new" do
    get new_bibtex_file_url
    assert_response :success
  end

  test "should create bibtex_file" do
    assert_difference('BibtexFile.count') do
      post bibtex_files_url, params: { bibtex_file: { content: @bibtex_file.content } }
    end

    assert_redirected_to bibtex_file_url(BibtexFile.last)
  end

  test "should show bibtex_file" do
    get bibtex_file_url(@bibtex_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_bibtex_file_url(@bibtex_file)
    assert_response :success
  end

  test "should update bibtex_file" do
    patch bibtex_file_url(@bibtex_file), params: { bibtex_file: { content: @bibtex_file.content } }
    assert_redirected_to bibtex_file_url(@bibtex_file)
  end

  test "should destroy bibtex_file" do
    assert_difference('BibtexFile.count', -1) do
      delete bibtex_file_url(@bibtex_file)
    end

    assert_redirected_to bibtex_files_url
  end
end
