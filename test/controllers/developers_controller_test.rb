require 'test_helper'

class DevelopersControllerTest < ActionController::TestCase
  test "should get reset_token" do
    get :reset_token
    assert_response :success
  end

  test "should get reset_fingerprint" do
    get :reset_fingerprint
    assert_response :success
  end

end
