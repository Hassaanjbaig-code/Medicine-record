class PushSubscribe < ApplicationRecord
  belongs_to :user
  # validates :endpoint, presence: true
  # validates :p256dh, presence: true
  # validates :auth, presence: true

  def self.build_vapid_details
    {
      # subject: "mailto:#{ENV['DEFAULT_EMAIL']}",
      public_key: Rails.application.credentials.dig(:Webpush, :public_key),
      private_key: Rails.application.credentials.dig(:Webpush, :private_key)
    }
  end

  def self.send_push_notification( id , name )
    Rails.logger.info("This is the id: #{name}")
    subscriptions = active_push_subscriptions id
    latest_subscription = subscriptions.last
    return unless latest_subscription

    message = {
      title: name,
      body: 'It is the time to eat medicine'
    }
    vapid_details = build_vapid_details
    send_web_push_notification(message, latest_subscription, vapid_details)
  end

  def push_notification_icon_url
    ActionController::Base.helpers.image_url('note.png')
  end

  def self.active_push_subscriptions(id)
    PushSubscribe.where(user_id: id)
  end

  def self.send_web_push_notification(message, subscription, vapid_details)
    WebPush.payload_send(
      message: JSON.generate(message),
      endpoint: subscription.endpoint,
      p256dh: subscription.p256db,
      auth: subscription.auth,
      vapid: vapid_details
    )
  end
end
