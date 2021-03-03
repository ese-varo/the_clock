require 'httparty'
require 'json'
class CurrentWeather < ApplicationService
  URL = 'https://api.openweathermap.org/data/2.5/weather?q='.freeze
  URL_SUFFIX = '&units=metric&APPID='.freeze

  def initialize(city_name)
    @city_name = city_name
  end

  def call
    endpoint = URL + @city_name + URL_SUFFIX + Rails.application.config.open_weather_key
    request(endpoint) 
  end

  private
   def request(url)
     HTTParty.get(url.gsub(' ', '%20')) 
   end

end
