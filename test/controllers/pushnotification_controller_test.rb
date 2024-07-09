require "test_helper"

class PushnotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pushnotification_index_url
    assert_response :success
  end

  test "should get create" do
    get pushnotification_create_url
    assert_response :success
  end
end
