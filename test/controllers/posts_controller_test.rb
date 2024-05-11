require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
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

  test "should show post" do
    get discussion_post_url(@post.discussion, @post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { text: @post.text } }
    assert_redirected_to discussion_url(@post.discussion)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to discussion_path(@post.discussion)
  end
end
