require 'test_helper'

class JsonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @json = jsons(:one)
  end

  test "should get index" do
    get jsons_url
    assert_response :success
  end

  test "should get new" do
    get new_json_url
    assert_response :success
  end

  test "should create json" do
    assert_difference('Json.count') do
      post jsons_url, params: { json: { content: @json.content } }
    end

    assert_redirected_to json_url(Json.last)
  end

  test "should show json" do
    get json_url(@json)
    assert_response :success
  end

  test "should get edit" do
    get edit_json_url(@json)
    assert_response :success
  end

  test "should update json" do
    patch json_url(@json), params: { json: { content: @json.content } }
    assert_redirected_to json_url(@json)
  end

  test "should destroy json" do
    assert_difference('Json.count', -1) do
      delete json_url(@json)
    end

    assert_redirected_to jsons_url
  end
end
