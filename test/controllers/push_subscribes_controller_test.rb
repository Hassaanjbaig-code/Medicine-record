require "test_helper"

class PushSubscribesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @push_subscribe = push_subscribes(:one)
  end

  test "should get index" do
    get push_subscribes_url
    assert_response :success
  end

  test "should get new" do
    get new_push_subscribe_url
    assert_response :success
  end

  test "should create push_subscribe" do
    assert_difference("PushSubscribe.count") do
      post push_subscribes_url, params: { push_subscribe: { auth: @push_subscribe.auth, endpoint: @push_subscribe.endpoint, p256db: @push_subscribe.p256db, string: @push_subscribe.string, subscribed: @push_subscribe.subscribed } }
    end

    assert_redirected_to push_subscribe_url(PushSubscribe.last)
  end

  test "should show push_subscribe" do
    get push_subscribe_url(@push_subscribe)
    assert_response :success
  end

  test "should get edit" do
    get edit_push_subscribe_url(@push_subscribe)
    assert_response :success
  end

  test "should update push_subscribe" do
    patch push_subscribe_url(@push_subscribe), params: { push_subscribe: { auth: @push_subscribe.auth, endpoint: @push_subscribe.endpoint, p256db: @push_subscribe.p256db, string: @push_subscribe.string, subscribed: @push_subscribe.subscribed } }
    assert_redirected_to push_subscribe_url(@push_subscribe)
  end

  test "should destroy push_subscribe" do
    assert_difference("PushSubscribe.count", -1) do
      delete push_subscribe_url(@push_subscribe)
    end

    assert_redirected_to push_subscribes_url
  end
end
