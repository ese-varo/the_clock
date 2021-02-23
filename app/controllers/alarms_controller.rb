class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms 
  end

  def new
    @alarm = Alarm.new
    @user = current_user
  end

  def create
    @alarm = current_user.alarms.create(alarm_params)
    if @alarm
      AlarmNotificationJob.set(wait_until: @alarm[:time]).perform_later(current_user, @alarm)
      redirect_to user_alarms_path(current_user)
    else
      render :new
    end
  end

  def edit 
    @alarm = current_user.alarms.find(params[:id])
    @user = current_user
  end

  def update
    @alarm = current_user.alarms.find(params[:id])

    if @alarm.update(alarm_params)
      redirect_to user_alarms_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @alarm = current_user.alarms.find(params[:id])
    if @alarm.destroy
      redirect_to user_alarms_path(current_user)
    else 
      render :new
    end
  end
  
  private
  def alarm_params
    params.require(:alarm).permit!
  end
end
