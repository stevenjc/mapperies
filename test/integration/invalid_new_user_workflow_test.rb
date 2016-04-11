require "test_helper"

class InvalidNewUserWorkflowTest < ActionDispatch::IntegrationTest

	test 'try to create an invalid email' do
	#	https!(false)
	#	get sign_in_url
	#	assert_response :success

		post_via_redirect "/users", :email => "test@testing"
		assert_equal '/users', path

	end

end
