class ClockController < ApplicationController
  def index
    @current_timezone = Time.zone
  end

  def timezones
    @timezones = ActiveSupport::TimeZone.all
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

  def destroy
    @timezone = current_user.timezones.find(params[:id])
    @timezone.destroy
    redirect_to root_path
  end

  private 
  def timezone_params
    params.permit(:name, :user_id)
  end
end
