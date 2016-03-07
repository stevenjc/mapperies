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
          email: "stevenjc@brandeis.edu",
          password: "bad")
      @copy = User.create(
          first_name: "Steven",
          last_name: "Colon",
          birthday: 2016-02-18,
          f_book: false,
          default_loc: "MyString",
          email: "stevenjc@brandeis.edu",
          password: "bad")

     @steven_different_email = User.create(
         first_name: "Steven",
         last_name: "Colon",
         birthday: 2016-02-18,
         f_book: false,
         default_loc: "MyString",
         email: "steven@brandeis.edu",
         password: "bad")
    end

    it "should save" do
        assert @steven.save, "Steven Record saved"
    end

    it "duplicate emails, dont save" do
        @steven.save
        assert_not @copy.save, "Record not saved since duplicate accounts found"
    end

    it "Account with only different email should save" do
        @steven.save
        assert @steven_different_email.save, "Steven saved an account with a different email"
    end

end
