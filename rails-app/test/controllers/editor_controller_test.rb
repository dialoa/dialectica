require 'test_helper'

class EditorControllerTest < ActionDispatch::IntegrationTest
  test "should get editor" do
    get editor_editor_url
    assert_response :success
  end

end
