require 'test_helper'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @discussion = discussions(:one)
  end

  test 'should get index' do
    get discussions_url
    assert_response :success
  end

  test 'should get new' do
    get new_discussion_url
    assert_response :success
  end

  test 'should create discussion' do
    sign_in users(:one)
    assert_difference('Discussion.count') do
      post discussions_url, params: { discussion: { description: @discussion.description, title: @discussion.title } }
    end

    assert_redirected_to discussion_url(Discussion.last)
  end

  test 'should show discussion' do
    sign_in users(:one)
    get discussion_url(@discussion)
    assert_response :success
  end

  test 'should not get edit' do
    get edit_discussion_url(@discussion)
    assert_redirected_to discussion_url(@discussion)
  end

  test 'should get edit' do
    sign_in users(:one)
    get edit_discussion_url(@discussion)
    assert_response :success
  end

  test 'should update discussion' do
    patch discussion_url(@discussion), params: { discussion: { description: @discussion.description, title: @discussion.title } }
    assert_redirected_to discussion_url(@discussion)
  end

  test 'should destroy discussion' do
    sign_in users(:one)
    assert_difference('Discussion.count', -1) do
      delete discussion_url(@discussion)
    end

    assert_redirected_to discussions_url
  end

  test 'should not destroy discussion' do
    assert_no_difference('Discussion.count') do
      delete discussion_url(@discussion)
    end

    assert_redirected_to discussion_url(@discussion)
  end
end
