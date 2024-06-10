require "test_helper"

class CdControllerTest < ActionDispatch::IntegrationTest
  test "should get .." do
    get cd_.._url
    assert_response :success
  end
end
