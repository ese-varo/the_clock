require 'httparty'
require 'json'
class IconWeather < ApplicationService
  URL = 'http://openweathermap.org/img/wn/'.freeze
  URL_SUFFIX = '@2x.png'.freeze

  def initialize(icon_code)
    @icon_code = icon_code
  end

  def call
    endpoint = URL + @icon_code + URL_SUFFIX
    endpoint
  end

  private
   def request(url)
    HTTParty.get(url.gsub(' ', '%20')) 
   end

end
