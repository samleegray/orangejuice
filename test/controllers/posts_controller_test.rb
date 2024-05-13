require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @post = posts(:one)
  end

  test 'should get index' do
    sign_in users(:one)
    get posts_url
    assert_response :success
  end

  test 'should show' do
    sign_in users(:one)
    get post_url(@post)
    assert_response :success
  end

  test 'should not get index not signed in' do
    get posts_url
    assert_redirected_to new_user_session_url
  end

  test 'should not get index not admin' do
    sign_in users(:two)
    get posts_url
    assert_redirected_to root_url
  end

  test 'should get new' do
    sign_in users(:one)
    get new_post_url
    assert_response :success
  end

  test 'should create post alone' do
    sign_in users(:one)
    assert_difference('Post.count') do
      post posts_url, params: { post: { text: @post.text, discussion_id: discussions(:one).id } }
    end

    assert_redirected_to discussion_url(discussions(:one))
  end

  test 'should not create post alone' do
    sign_in users(:one)
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { text: '', discussion_id: discussions(:one).id } }
    end

    assert_response :unprocessable_entity
  end

  test 'should not show post' do
    get posts_url(@post)
    assert_response :unauthorized
  end

  test 'should show post' do
    get discussion_post_url(@post.discussion, @post)
    assert_response :success
    assert_select 'title', "#{@post.discussion.title} | Orangejuice"
  end

  test 'should get edit' do
    sign_in users(:one)
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    sign_in users(:one)
    patch post_url(@post), params: { post: { text: @post.text } }
    assert_redirected_to discussion_url(@post.discussion)
  end

  test 'should not update post' do
    sign_in users(:one)
    patch post_url(@post), params: { post: { text: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy post' do
    sign_in users(:one)
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to discussion_path(@post.discussion)
  end
end
