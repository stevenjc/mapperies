require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "should save" do
    user = users(:one)
    assert user.save

  end

  test "shouldn't save" do
    user = users(:one)
    user.save
    assert_not user.save
  end
end
