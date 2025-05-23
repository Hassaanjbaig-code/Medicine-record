require "test_helper"

class DoctorAppointmentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doctor_appointment_index_url
    assert_response :success
  end
end
