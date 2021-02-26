class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms
    @alarms = @alarms.map do |alarm|
      [alarm, alarm.alarmDays]
    end
    @alarms
  end

  def new
    @alarm = Alarm.new
    @user = current_user
    @days = create_days
  end

  def create
    if params[:days].empty?
      # message of invalid
    else 
      @alarm = current_user.alarms.create(alarm_params)
      if @alarm
        hours, minutes = params[:alarm][:time].split(':')
        params[:days].each do |day|
          new_time = DateTime.parse(day).change(hour: hours.to_i, min: minutes.to_i)
          @alarm.alarmDays.create({daytime: new_time})
          AlarmNotificationJob.set(wait_until: new_time).perform_later(current_user, @alarm)
        end
        redirect_to user_alarms_path(current_user)
      else
        render :new
      end
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
    params.require(:alarm).permit(:label)
  end

  def create_days
    days = Hash.new
    7.times do |count|
      days[Time.now.advance(days: count).strftime("%A")] = Time.now.advance(days: count)
    end
    days
  end
end
