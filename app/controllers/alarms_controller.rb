class AlarmsController < ApplicationController
  
  
  def index
    @alarms = Alarm.where(user_id: current_user.id)
  end

  def new
    @alarm = Alarm.new
    @user = current_user
  end

  def create
    @alarm = Alarm.new(alarm_params)
    if @alarm.save
      AlarmNotificationJob.set(wait_until: @alarm[:time]).perform_later(current_user, @alarm)
      redirect_to user_alarms_path(current_user)
    else
      render :new
    end
  end

  def edit 
    @alarm = Alarm.find(params[:id]) 
    @user = current_user
  end

  def update
    @alarm = Alarm.find(params[:id])

    if @alarm.update(alarm_params)
      redirect_to user_alarms_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @alarm = Alarm.find(params[:id])
    if @alarm.destroy
      redirect_to user_alarms_path(current_user)
    else 
      render :new
    end
  end
  
  private
  def alarm_params
    form_params = params.require(:alarm).permit!
    form_params[:user_id] = params[:user_id]
    form_params
  end
end
