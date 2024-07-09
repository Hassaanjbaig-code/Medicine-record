require "application_system_test_case"

class PushSubscribesTest < ApplicationSystemTestCase
  setup do
    @push_subscribe = push_subscribes(:one)
  end

  test "visiting the index" do
    visit push_subscribes_url
    assert_selector "h1", text: "Push subscribes"
  end

  test "should create push subscribe" do
    visit push_subscribes_url
    click_on "New push subscribe"

    fill_in "Auth", with: @push_subscribe.auth
    fill_in "Endpoint", with: @push_subscribe.endpoint
    fill_in "P256db", with: @push_subscribe.p256db
    fill_in "String", with: @push_subscribe.string
    check "Subscribed" if @push_subscribe.subscribed
    click_on "Create Push subscribe"

    assert_text "Push subscribe was successfully created"
    click_on "Back"
  end

  test "should update Push subscribe" do
    visit push_subscribe_url(@push_subscribe)
    click_on "Edit this push subscribe", match: :first

    fill_in "Auth", with: @push_subscribe.auth
    fill_in "Endpoint", with: @push_subscribe.endpoint
    fill_in "P256db", with: @push_subscribe.p256db
    fill_in "String", with: @push_subscribe.string
    check "Subscribed" if @push_subscribe.subscribed
    click_on "Update Push subscribe"

    assert_text "Push subscribe was successfully updated"
    click_on "Back"
  end

  test "should destroy Push subscribe" do
    visit push_subscribe_url(@push_subscribe)
    click_on "Destroy this push subscribe", match: :first

    assert_text "Push subscribe was successfully destroyed"
  end
end
