require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "testy@example.com", password: "password12", password_confirmation: "password12")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should be 60 chars or less" do
    @user.name = "a" * 61
    assert_not @user.valid?
  end

  test "email should be 255 chars or less" do
    @user.email = "a" * 256
    assert_not @user.valid?
    @user.email = "a" * 245 + "@gmail.com"
    assert @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = ["user@example,com", "user_at_foo.org", "user.name@example.", "foo@bar_baz.com", "foo@bar+baz.com", "foo@bar..com"]
    invalid_addresses.each do |inv_email|
      @user.email = inv_email
      assert_not @user.valid?, "#{inv_email.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "    "
    assert_not @user.valid?
  end

  test "password should be at least 10 chars long" do
    @user.password = @user.password_confirmation = "a" * 10
    assert @user.valid?
    @user.password = @user.password_confirmation = "a"
    assert_not @user.valid?
  end
end
