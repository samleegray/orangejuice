require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @post = posts(:one)
  end

  test "should get index" do
    sign_in users(:one)
    get posts_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post discussion_posts_url(discussions(:one)), params: { post: { text: @post.text, discussion_id: discussions(:one).id } }
    end

  assert_redirected_to discussion_url(discussions(:one))
end
  # test "should create post" do
  #   assert_difference("Post.count") do
  #     post discussion_post_url, params: { post: { text: @post.text, discussion_id: discussions(:one).id } }
  #   end
  #
  #   assert_redirected_to post_url(Post.last)
  # end

  test "should not show post" do
    get posts_url(@post)
    assert_response :unauthorized
  end

  test "should show post" do
    sign_in users(:one)
    get discussion_post_url(@post.discussion, @post)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    sign_in users(:one)
    patch post_url(@post), params: { post: { text: @post.text } }
    assert_redirected_to discussion_url(@post.discussion)
  end

  test "should destroy post" do
    sign_in users(:one)
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to discussion_path(@post.discussion)
  end
end
