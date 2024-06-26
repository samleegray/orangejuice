class DiscussionsPostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @post = posts(:one)
  end

  test 'should get index' do
    sign_in users(:one)
    get discussion_posts_url(discussions(:one))
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:one)
    get new_discussion_post_url(discussions(:one))
    assert_response :success
  end

  test 'should begin edit' do
    sign_in users(:one)
    get edit_discussion_post_url(discussions(:one), posts(:one))
    assert_response :success
  end

  test 'should create post' do
    sign_in users(:one)
    assert_difference('Post.count') do
      post discussion_posts_url(discussions(:one)), params: { post: { text: @post.text,
                                                                      discussion_id: discussions(:one).id } }
    end

    assert_redirected_to discussion_url(discussions(:one))
  end

  test 'should not create post' do
    sign_in users(:one)
    assert_no_difference('Post.count') do
      post discussion_posts_url(discussions(:one)), params: { post: { text: '',
                                                                      discussion_id: discussions(:one).id } }
    end

    assert_response :unprocessable_entity
  end

  test 'should update post' do
    sign_in users(:one)
    patch discussion_post_url(@post.discussion, @post), params: { post: { text: @post.text } }
    assert_redirected_to discussion_url(@post.discussion)
  end

  test 'should not update post not owner' do
    sign_in users(:two)
    patch discussion_post_url(@post.discussion, @post), params: { post: { text: @post.text } }
    assert_redirected_to discussion_url(@post.discussion)
  end

  test 'should not update post' do
    sign_in users(:one)
    patch discussion_post_url(@post.discussion, @post), params: { post: { text: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy post' do
    sign_in users(:one)
    assert_difference('Post.count', -1) do
      delete discussion_post_url(@post.discussion, @post)
    end

    assert_redirected_to discussion_path(@post.discussion)
  end

end