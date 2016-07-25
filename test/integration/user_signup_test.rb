require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up" do
    get signup_url
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}
    end
    assert_template 'users/new'
  end

  test 'valid sign up' do
    get signup_url
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "Dennis", email: "dennis@paddyspub.com", password: "password12", password_confirmation: "password12"}
    end
    assert_template 'users/show'
  end
end
