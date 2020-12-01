require 'test_helper'

class ToolsControllerTest < ActionDispatch::IntegrationTest
  test "should get csv" do
    get tools_csv_url
    assert_response :success
  end

end
