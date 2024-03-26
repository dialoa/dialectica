require 'test_helper'

class PandocControllerTest < ActionDispatch::IntegrationTest
  test "should get pandoc" do
    get pandoc_pandoc_url
    assert_response :success
  end

  test "should get pandoc_output" do
    get pandoc_pandoc_output_url
    assert_response :success
  end

end
