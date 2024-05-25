require "application_system_test_case"

class StartEndMedicinesTest < ApplicationSystemTestCase
  setup do
    @start_end_medicine = start_end_medicines(:one)
  end

  test "visiting the index" do
    visit start_end_medicines_url
    assert_selector "h1", text: "Start end medicines"
  end

  test "should create start end medicine" do
    visit start_end_medicines_url
    click_on "New start end medicine"

    fill_in "End date", with: @start_end_medicine.end_date
    check "Everyday" if @start_end_medicine.everyday
    fill_in "Medicine", with: @start_end_medicine.medicine_id
    fill_in "Start date", with: @start_end_medicine.start_date
    click_on "Create Start end medicine"

    assert_text "Start end medicine was successfully created"
    click_on "Back"
  end

  test "should update Start end medicine" do
    visit start_end_medicine_url(@start_end_medicine)
    click_on "Edit this start end medicine", match: :first

    fill_in "End date", with: @start_end_medicine.end_date
    check "Everyday" if @start_end_medicine.everyday
    fill_in "Medicine", with: @start_end_medicine.medicine_id
    fill_in "Start date", with: @start_end_medicine.start_date
    click_on "Update Start end medicine"

    assert_text "Start end medicine was successfully updated"
    click_on "Back"
  end

  test "should destroy Start end medicine" do
    visit start_end_medicine_url(@start_end_medicine)
    click_on "Destroy this start end medicine", match: :first

    assert_text "Start end medicine was successfully destroyed"
  end
end
