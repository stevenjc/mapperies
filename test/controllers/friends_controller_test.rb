require 'test_helper'

class FriendsControllerTest < ActionController::TestCase

   test "should require login" do
    get :index
    response.should redirect_to sign_in_path
   end
end
