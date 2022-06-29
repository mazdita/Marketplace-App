require "test_helper"

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get authenticate" do
    get api_authenticate_url
    assert_response :success
  end
end
