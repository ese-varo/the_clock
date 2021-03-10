class ClockController < ApplicationController
  def main
    current_timezone
    @current_weather = current_weather(@current_timezone.name)
  end

  def index
    current_timezone
    @current_weather = current_weather(@current_timezone.name)
    @user_timezones = current_user.timezones
  end

  def timezones
    @timezones = user_signed_in? ? all_timezones[1..5].map do |timezone|
      {timezone: timezone, weather: current_weather(timezone.name)}
    end : all_timezones.map { |timezone| {timezone: timezone} }
  end

  def show
    @timezone = get_new_support_timezone(params[:id])
    @weather = next_forecast_days(@timezone.name)
  end

  def new
    @timezone = Timezone.new
  end

  def create
    @timezone = current_user.timezones.new(timezone_params)
    if @timezone.save
      flash[:success] = "Timezone save as favorite"
      redirect_to clock_index_path
    else
      flash[:danger] = "Please check the timezone"
      render :new
    end
  end

  def edit
    @timezones = all_timezones.map {|zone| [zone.name, zone.name]}
  end

  def update
    current_user.timezone = params[:timezone]
    if current_user.save
      redirect_to clock_index_path
    else 
      render :new
    end
  end
  
  def destroy
    @timezone = Timezone.find(params[:id])
    if @timezone.destroy
      flash[:info] = "Timezone deleted"
      redirect_to clock_index_path
    end
  end

  private 
  def timezone_params
    params.permit(:name)
  end

  def user_timezone
    user_signed_in? && current_user.timezone ? get_new_support_timezone(current_user.timezone) : Time.zone
  end

  def get_new_support_timezone(timezone)
    ActiveSupport::TimeZone.new(timezone)
  end

  def all_timezones
    ActiveSupport::TimeZone.all
  end

  def current_timezone
    @current_timezone ||= user_timezone
  end

  def current_weather(timezone_name)
    CurrentWeather.call(timezone_name)
  end
  
  def forecast_weather(timezone_name)
    ForecastWeather.call(timezone_name)
  end

  def next_forecast_days(timezone_name)
    NextForecastDays.call(timezone_name)
  end
end
