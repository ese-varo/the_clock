class WeatherSetter < ApplicationService
  def initialize(timezones)
    @timezones = timezones
  end

  def call
    set_weather_to_timezones
  end

  def set_weather_to_timezones
    @timezones.map do |timezone|
      class << timezone
        def weather
          CurrentWeather.call(@name)
        end
      end
    end
    @timezones
  end
end
