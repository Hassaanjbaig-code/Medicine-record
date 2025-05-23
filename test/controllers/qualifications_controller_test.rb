require "test_helper"

class QualificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get qualifications_new_url
    assert_response :success
  end

  test "should get create" do
    get qualifications_create_url
    assert_response :success
  end
end
