class ClockController < ApplicationController
  def index
    @current_timezone = Time.zone
  end

  def timezones
    @timezones = ActiveSupport::TimeZone.all
  end
end
