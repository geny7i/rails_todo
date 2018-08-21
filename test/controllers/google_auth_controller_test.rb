require 'test_helper'

class GoogleAuthControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get google_auth_callback_url
    assert_response :success
  end

  test "should get redirect" do
    get google_auth_redirect_url
    assert_response :success
  end

end
