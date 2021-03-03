class ClockController < ApplicationController
  def main
    current_timezone
    @current_weather = current_weather(@current_timezone.name)
  end

  def index
    current_timezone
    @current_weather = current_weather(@current_timezone.name)
  end

  def timezones
    @timezones = ActiveSupport::TimeZone.all[1..4].map do |timezone|
      {timezone: timezone, weather: current_weather(timezone.name)}
    end
  end

  def favorites
    @user_timezones = current_user.timezones
  end

  def new
    @timezone = Timezone.new
  end

  def create
    @timezone = current_user.timezones.new(timezone_params)
    if @timezone.save
      flash[:success] = "Timezone save as favorite"
    else
      render :new
    end
  end

  def edit
    @timezones = ActiveSupport::TimeZone.all.map {|zone| [zone.name, zone.name]}
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
    @timezone.destroy
    redirect_to root_path
  end

  private 
  def timezone_params
    params.permit(:name, :user_id)
  end

  def user_timezone
    user_signed_in? && current_user.timezone ? ActiveSupport::TimeZone.new(current_user.timezone) : Time.zone
  end

  def current_timezone
    @current_timezone ||= user_timezone
  end

  def current_weather(timezone_name)
    CurrentWeather.call(timezone_name)
  end
end
