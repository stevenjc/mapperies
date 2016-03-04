require_relative 'test/test_helper'

before do
  Users.destroy_all
  Users.create(name: "Admin Man", password_digest: "password", admin: 1)
  Users.create(name: "Admin Man 2", password_digest: "password2", admin: 1)
end

describe "deleting admins" do
  it "can delete an admin" do
    Users.first.delete
    Users.count.must_equal 1
  end

  it "won't delete the last admin" do
    Users.first.delete
    Users.first.delete
    Users.count.must_equal 1
  end
end
