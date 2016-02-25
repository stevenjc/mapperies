require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get albums" do
    get :albums
    assert_response :success
  end

end
