require "test_helper"

class SpecializationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get specializations_new_url
    assert_response :success
  end
end
