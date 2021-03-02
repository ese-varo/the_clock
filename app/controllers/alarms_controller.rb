class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms
  end

  def new
    @alarm = Alarm.new
  end

  def create
    @alarm = current_user.alarms.create(alarm_params)
    if @alarm
      hours, minutes = params[:alarm][:time].split(':')
      alarm_params[:days].each do |day|
        new_time = DateTime.parse(day).change(hour: hours.to_i, min: minutes.to_i)
        AlarmNotificationJob.set(wait_until: new_time).perform_later(current_user, @alarm)
      end
      redirect_to alarms_path
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
      redirect_to alarms_path
    else
      render :new
    end
  end

  def destroy
    @alarm = Alarm.find(params[:id])
    if @alarm.destroy
      redirect_to alarms_path
    else 
      render :new
    end
  end
  
  private
  def alarm_params
    params.require(:alarm).permit!
  end
end
