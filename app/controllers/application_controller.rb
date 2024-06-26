class ApplicationController < ActionController::Base
  around_action :set_time_zone, if: :current_user

  private
  def set_time_zone
    Time.use_zone(current_user.time_zone) { yield }
  end
end
