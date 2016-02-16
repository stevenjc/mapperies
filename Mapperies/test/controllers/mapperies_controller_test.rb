require 'test_helper'

class MapperiesControllerTest < ActionController::TestCase
  test "should get landing" do
    get :landing
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get album" do
    get :album
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

end
