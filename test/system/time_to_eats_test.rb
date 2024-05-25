require "application_system_test_case"

class TimeToEatsTest < ApplicationSystemTestCase
  setup do
    @time_to_eat = time_to_eats(:one)
  end

  test "visiting the index" do
    visit time_to_eats_url
    assert_selector "h1", text: "Time to eats"
  end

  test "should create time to eat" do
    visit time_to_eats_url
    click_on "New time to eat"

    fill_in "Medicine", with: @time_to_eat.medicine_id
    fill_in "Time to eat", with: @time_to_eat.time_to_eat
    click_on "Create Time to eat"

    assert_text "Time to eat was successfully created"
    click_on "Back"
  end

  test "should update Time to eat" do
    visit time_to_eat_url(@time_to_eat)
    click_on "Edit this time to eat", match: :first

    fill_in "Medicine", with: @time_to_eat.medicine_id
    fill_in "Time to eat", with: @time_to_eat.time_to_eat
    click_on "Update Time to eat"

    assert_text "Time to eat was successfully updated"
    click_on "Back"
  end

  test "should destroy Time to eat" do
    visit time_to_eat_url(@time_to_eat)
    click_on "Destroy this time to eat", match: :first

    assert_text "Time to eat was successfully destroyed"
  end
end
