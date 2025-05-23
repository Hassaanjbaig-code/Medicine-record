require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get patients_new_url
    assert_response :success
  end
end
