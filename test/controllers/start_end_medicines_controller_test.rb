require "test_helper"

class StartEndMedicinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @start_end_medicine = start_end_medicines(:one)
  end

  test "should get index" do
    get start_end_medicines_url
    assert_response :success
  end

  test "should get new" do
    get new_start_end_medicine_url
    assert_response :success
  end

  test "should create start_end_medicine" do
    assert_difference("StartEndMedicine.count") do
      post start_end_medicines_url, params: { start_end_medicine: { end_date: @start_end_medicine.end_date, everyday: @start_end_medicine.everyday, medicine_id: @start_end_medicine.medicine_id, start_date: @start_end_medicine.start_date } }
    end

    assert_redirected_to start_end_medicine_url(StartEndMedicine.last)
  end

  test "should show start_end_medicine" do
    get start_end_medicine_url(@start_end_medicine)
    assert_response :success
  end

  test "should get edit" do
    get edit_start_end_medicine_url(@start_end_medicine)
    assert_response :success
  end

  test "should update start_end_medicine" do
    patch start_end_medicine_url(@start_end_medicine), params: { start_end_medicine: { end_date: @start_end_medicine.end_date, everyday: @start_end_medicine.everyday, medicine_id: @start_end_medicine.medicine_id, start_date: @start_end_medicine.start_date } }
    assert_redirected_to start_end_medicine_url(@start_end_medicine)
  end

  test "should destroy start_end_medicine" do
    assert_difference("StartEndMedicine.count", -1) do
      delete start_end_medicine_url(@start_end_medicine)
    end

    assert_redirected_to start_end_medicines_url
  end
end
