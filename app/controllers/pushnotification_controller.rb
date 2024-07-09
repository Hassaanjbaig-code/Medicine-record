class PushnotificationController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def create
    WebPush.payload_send webpush_parm

    head :ok
  end

  private
  def webpush_parm
    @subcribe = PushSubscribe.last
    p @subcribe.p256db
    user_message = { title: "Hello world, the time is #{Time.zone.now}" }
    # endpoint = @subcribe.endpoint
    vapid_details = build_vapid_details
    # p256dh = @subscribe.p256db
    # auth = @subscribe.auth
    # api_key = enpoint =~ /\.google.com\// = ENV.fetch('GOOGLE_CLOUD_MESSAGE_API_KEY') || ""
    p vapid_Details
    { message: JSON.generate(user_message),
      endpoint: @subcribe.endpoint,
      p256dh: @subcribe.p256db,
      auth: @subcribe.auth,
      vapid: vapid_details }
  end

  def build_vapid_details
    {
      subject: "mailto:hassaanb0@gmail.com",
      public_key: Rails.application.credentials.dig(:Webpush, :public_key),
      private_key: Rails.application.credentials.dig(:Webpush, :private_key)
    }
  end
end
