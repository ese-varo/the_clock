class NextForecastDays < ApplicationService
  def initialize(timezone_name)
    @forecast = ForecastWeather.call(timezone_name)
  end

  def call 
    weather_days = []
    total_days = @forecast["list"].length/5
    5.times { |position| weather_days.push(@forecast["list"][(position*total_days)+2]) }
    weather_days
  end
end
