class PushSubscribesController < ApplicationController
  protect_from_forgery except: :subscribe
  before_action :authenticate_user!

  def index
    @subscribe = PushSubscribe.all

    render json: { subscribe: @subscribe }, status: :ok
  end

  # POST /push_subscribes or /push_subscribes.json
  def create
    @subscription = current_user.push_subscribe.create(
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
    PushSubscribe.send_push_notification(current_user.id, "Kastine")
    render json: { message: 'Subscribed successfully' }, status: :ok
  end

  def check_logged_in
    queue_push_notification if current_user.logged_in?
  end
  private

  def queue_push_notification
    HelloWorldSchedular.perform_async(current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def push_subscribe_params
    params.require(:push_subscribe).permit(:endpoint, :p256dh, :auth)
  end
end
