require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get login_url
    assert_response :success
  end
end
