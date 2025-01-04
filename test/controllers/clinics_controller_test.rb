require "test_helper"

class ClinicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get clinics_new_url
    assert_response :success
  end
end
