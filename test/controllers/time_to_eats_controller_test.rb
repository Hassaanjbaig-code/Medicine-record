require "test_helper"

class TimeToEatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_to_eat = time_to_eats(:one)
  end

  test "should get index" do
    get time_to_eats_url
    assert_response :success
  end

  test "should get new" do
    get new_time_to_eat_url
    assert_response :success
  end

  test "should create time_to_eat" do
    assert_difference("TimeToEat.count") do
      post time_to_eats_url, params: { time_to_eat: { medicine_id: @time_to_eat.medicine_id, time_to_eat: @time_to_eat.time_to_eat } }
    end

    assert_redirected_to time_to_eat_url(TimeToEat.last)
  end

  test "should show time_to_eat" do
    get time_to_eat_url(@time_to_eat)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_to_eat_url(@time_to_eat)
    assert_response :success
  end

  test "should update time_to_eat" do
    patch time_to_eat_url(@time_to_eat), params: { time_to_eat: { medicine_id: @time_to_eat.medicine_id, time_to_eat: @time_to_eat.time_to_eat } }
    assert_redirected_to time_to_eat_url(@time_to_eat)
  end

  test "should destroy time_to_eat" do
    assert_difference("TimeToEat.count", -1) do
      delete time_to_eat_url(@time_to_eat)
    end

    assert_redirected_to time_to_eats_url
  end
end
