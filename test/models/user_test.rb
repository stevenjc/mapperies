require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
<<<<<<< HEAD
    describe user_save do
        before do
            User.destroy_all

        end
        test "should save" do
            user = users(:one)
            assert user.save, "User has been saved"
        end

        test "should not save" do
            user = users(:one)
            user.save
            assert_not user.save, "Email already in db"
        end
    end

=======


  test "should save" do
    user = users(:one)
    assert user.save

  end

  test "shouldn't save" do
    user = users(:one)
    user.save
    assert_not user.save
  end
>>>>>>> authentication
end
