class TimezonesController < ApplicationController
  def index
    timezones = Timezone.where(user_id: current_user.id) 
    @user_timezones = timezones.to_a.map { |time| ActiveSupport::TimeZone.new(time.name) }
  end
end
