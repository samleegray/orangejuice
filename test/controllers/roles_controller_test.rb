require 'test_helper'

class RolesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @role = roles(:admin)
    sign_in users(:one)
  end

  test 'should get index' do
    get roles_url
    assert_response :success
  end

  test 'should get new' do
    get new_role_url
    assert_response :success
  end

  test 'should create role' do
    assert_difference('Role.count') do
      post roles_url, params: { role: { name: 'brand_new' } }
    end

    assert_redirected_to role_url(Role.last)
  end

  test 'should not create role' do
    assert_no_difference('Role.count') do
      post roles_url, params: { role: { name: '' } }
    end

    assert_response :unprocessable_entity
  end

  test 'should show role' do
    get role_url(@role)
    assert_response :success
  end

  test 'should get edit' do
    get edit_role_url(@role)
    assert_response :success
  end

  test 'should update role' do
    patch role_url(@role), params: { role: { name: @role.name } }
    assert_redirected_to role_url(@role)
  end

  test 'should not update role' do
    patch role_url(@role), params: { role: { name: '' } }
    assert_redirected_to role_url(@role)
  end

  test 'should destroy role' do
    # change to using a role that is not used by any users in the fixtures
    @role = roles(:editor)
    assert_difference('Role.count', -1) do
      delete role_url(@role)
    end

    assert_redirected_to roles_url
  end
end
