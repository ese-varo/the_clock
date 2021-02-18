class ClockController < ApplicationController
  def index
    @current_timezone = Time.zone
  end

  def timezones
    @timezones = ActiveSupport::TimeZone.all
  end

  def new
    @timezone = Timezone.new
  end

  def create
    puts params
    @timezone = Timezone.new(timezone_params)
    if @timezone.save
      flash[:success] = "Timezone save as favorite"
    else
      render :new
    end
  end

  private 
  def timezone_params
    params.permit(:name, :user_id)
  end
end
