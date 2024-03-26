require 'test_helper'

class WebSiteContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @web_site_content = web_site_contents(:one)
  end

  test "should get index" do
    get web_site_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_web_site_content_url
    assert_response :success
  end

  test "should create web_site_content" do
    assert_difference('WebSiteContent.count') do
      post web_site_contents_url, params: { web_site_content: { content: @web_site_content.content, identifier: @web_site_content.identifier, title: @web_site_content.title } }
    end

    assert_redirected_to web_site_content_url(WebSiteContent.last)
  end

  test "should show web_site_content" do
    get web_site_content_url(@web_site_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_web_site_content_url(@web_site_content)
    assert_response :success
  end

  test "should update web_site_content" do
    patch web_site_content_url(@web_site_content), params: { web_site_content: { content: @web_site_content.content, identifier: @web_site_content.identifier, title: @web_site_content.title } }
    assert_redirected_to web_site_content_url(@web_site_content)
  end

  test "should destroy web_site_content" do
    assert_difference('WebSiteContent.count', -1) do
      delete web_site_content_url(@web_site_content)
    end

    assert_redirected_to web_site_contents_url
  end
end
