require "application_system_test_case"

class DoctersTest < ApplicationSystemTestCase
  setup do
    @docter = docters(:one)
  end

  test "visiting the index" do
    visit docters_url
    assert_selector "h1", text: "Docters"
  end

  test "should create docter" do
    visit docters_url
    click_on "New docter"

    fill_in "Email", with: @docter.Email
    fill_in "Fullname", with: @docter.Fullname
    fill_in "Specialty", with: @docter.Specialty
    fill_in "Users", with: @docter.users_id
    click_on "Create Docter"

    assert_text "Docter was successfully created"
    click_on "Back"
  end

  test "should update Docter" do
    visit docter_url(@docter)
    click_on "Edit this docter", match: :first

    fill_in "Email", with: @docter.Email
    fill_in "Fullname", with: @docter.Fullname
    fill_in "Specialty", with: @docter.Specialty
    fill_in "Users", with: @docter.users_id
    click_on "Update Docter"

    assert_text "Docter was successfully updated"
    click_on "Back"
  end

  test "should destroy Docter" do
    visit docter_url(@docter)
    click_on "Destroy this docter", match: :first

    assert_text "Docter was successfully destroyed"
  end
end
