# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  def setup
    @user = users(:one)
  end

  test 'should not get index' do
    get users_url
    assert_redirected_to new_user_session_url
  end

  test 'should get index' do
    sign_in users(:one)
    get users_url
    assert_response :success
  end

  test 'should show user' do
    sign_in users(:one)
    get user_url(@user)
    assert_response :success
  end

  test 'should delete user' do
    sign_in @user
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end

  def teardown
    # Do nothing
  end


end
