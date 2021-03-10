class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms.map {|alarm| helpers.decorate(alarm)}
  end

  def new
    @alarm = Alarm.new
  end

  def create
    @alarm = current_user.alarms.create(alarm_params)
    if @alarm.valid?
      hours, minutes = params[:alarm][:time].split(':')
      alarm_params[:days].each do |day|
        new_time = DateTime.parse(day).change(hour: hours.to_i, min: minutes.to_i)
        AlarmNotificationJob.set(wait_until: new_time).perform_later(current_user, @alarm)
      end
      flash[:success] = 'New alarm created successfully'
      redirect_to alarms_path
    else
      shows_errors(@alarm.errors)
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
      flash[:success] = 'Alarm updated successfully'
      redirect_to alarms_path
    else
      shows_errors(@alarm.errors)
      render :new
    end
  end

  def destroy
    @alarm = Alarm.find(params[:id])
    if @alarm.destroy
      flash[:success] = 'Alarm deleted successfully'
      redirect_to alarms_path
    else 
      shows_errors(@alarm.errors)
      render :new
    end
  end
  
  private
  def alarm_params
    params.require(:alarm).permit!
  end

  def shows_errors(errors)
    errors.full_messages.each do |error|
      flash[:danger] = error
    end
  end
end
