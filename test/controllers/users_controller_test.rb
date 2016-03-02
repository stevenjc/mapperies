require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  

  #18.2-Testability: The three added tests
  test "should create user with password" do
    assert_difference('User.count') do
      post :create, user: { name: 'Bob', password: 'Joe123', password_confirmation: 'Joe123' }
    end
  end

  test "after updating user, changes should be made" do
    post :update, id: @user, user: { name: @user.name, password: 'joeshmoe', password_confirmation: 'joeshmoe' }
    assert_redirected_to users_path
  end

  test "should show the user" do
      get :show, id: @user
      assert_response :success
  end
end
