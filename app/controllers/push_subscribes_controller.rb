class PushSubscribesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @subscribe = PushSubscribe.all

    render json: { subscribe: @subscribe }, status: :ok
  end

  # POST /push_subscribes or /push_subscribes.json
  def create
    @subscription = PushSubscribe.create(
      endpoint: params[:endpoint],
      p256db: params[:p256db],
      auth: params[:auth],
      subscribed: true
    )
    p @subscription
    if @subscription.save
      render json: { message: 'Subscription successfully saved' }, status: :ok
    else
      render json: { error: 'Error in storing subscription' }, status: :unprocessable_entity
    end
  end

  def subscribe
    send_push_notification
  end

  private

  # Only allow a list of trusted parameters through.
  def push_subscribe_params
    params.require(:push_subscribe).permit(:endpoint, :p256dh, :auth)
  end

  def build_vapid_details
    {
      # subject: "mailto:#{ENV['DEFAULT_EMAIL']}",
      public_key: Rails.application.credentials.dig(:Webpush, :public_key),
      private_key: Rails.application.credentials.dig(:Webpush, :private_key)
    }
  end

  def send_push_notification
    subscriptions = active_push_subscriptions
    latest_subscription = subscriptions.last
    return unless latest_subscription

    message = {
      title: 'Hello World',
      body: 'This is the body'
    }
    vapid_details = build_vapid_details
    send_web_push_notification(message, latest_subscription, vapid_details)
  end

  def push_notification_icon_url
    ActionController::Base.helpers.image_url('note.png')
  end

  def active_push_subscriptions
    PushSubscribe.where(subscribed: true)
  end

  def send_web_push_notification(message, subscription, vapid_details)
    WebPush.payload_send(
      message: JSON.generate(message),
      endpoint: subscription.endpoint,
      p256dh: subscription.p256db,
      auth: subscription.auth,
      vapid: vapid_details
    )
  end
end
