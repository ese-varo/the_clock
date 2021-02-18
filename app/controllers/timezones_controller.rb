class TimezonesController < ApplicationController
  def index
    timezones = Timezone.all  
    @user_timezones = timezones.to_a.map { |time| ActiveSupport::TimeZone.new(time.name) }
  end
end
