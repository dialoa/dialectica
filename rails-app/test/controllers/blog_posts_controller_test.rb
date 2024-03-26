require 'test_helper'

class BlogPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog_post = blog_posts(:one)
  end

  test "should get index" do
    get blog_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_post_url
    assert_response :success
  end

  test "should create blog_post" do
    assert_difference('BlogPost.count') do
      post blog_posts_url, params: { blog_post: { content: @blog_post.content, description: @blog_post.description, keywords: @blog_post.keywords, search_field: @blog_post.search_field, title: @blog_post.title } }
    end

    assert_redirected_to blog_post_url(BlogPost.last)
  end

  test "should show blog_post" do
    get blog_post_url(@blog_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_post_url(@blog_post)
    assert_response :success
  end

  test "should update blog_post" do
    patch blog_post_url(@blog_post), params: { blog_post: { content: @blog_post.content, description: @blog_post.description, keywords: @blog_post.keywords, search_field: @blog_post.search_field, title: @blog_post.title } }
    assert_redirected_to blog_post_url(@blog_post)
  end

  test "should destroy blog_post" do
    assert_difference('BlogPost.count', -1) do
      delete blog_post_url(@blog_post)
    end

    assert_redirected_to blog_posts_url
  end
end
