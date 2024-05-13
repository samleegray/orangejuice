require 'application_system_test_case'

class RolesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @role = roles(:admin)
    sign_in users(:one)
  end

  test 'visiting the index' do
    visit roles_url
    assert_selector 'h1', text: 'Roles'
  end

  test 'signed out' do
    sign_out :user
    visit roles_url
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'signed in not admin' do
    sign_out :user
    sign_in users(:two)
    visit roles_url
    assert_text 'You do not have access to this page'
  end

  test 'should create role' do
    visit roles_url
    click_on 'New role'

    fill_in 'Name', with: 'new_role'
    click_on 'Create Role'

    assert_text 'Role was successfully created'
    click_on 'Back'
  end

  test 'should update Role' do
    visit role_url(@role)
    click_on 'Edit this role', match: :first

    fill_in 'Name', with: @role.name
    click_on 'Update Role'

    assert_text 'Role was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Role' do
    @role = roles(:editor)
    visit role_url(@role)
    click_on 'Destroy this role', match: :first

    assert_text 'Role was successfully destroyed'
  end
end
