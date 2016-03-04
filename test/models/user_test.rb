require_relative '../test_helper'

describe User do
  before do
      User.destroy_all
      @steven = User.create(
          first_name: "Steven",
          last_name: "Colon",
          birthday: 2016-02-18,
          f_book: false,
          default_loc: "MyString",
          email: "stevenjc@brandeis.edu")
  end

  it "should save" do
    assert_not @steven.save

  end

  it "shouldn't save" do

    @steven.save
    assert_not @steven.save
  end
end
