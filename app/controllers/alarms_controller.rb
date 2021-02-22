class AlarmsController < ApplicationController
  def index
    @alarms = Alarm.where(user_id: current_user.id)
  end

  def new
    @alarm = Alarm.new
    @user = current_user
    name_days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @days = name_days.each_with_index.map { |name, index| Day.new(index, name) }
  end

  def create
    @alarm = Alarm.new(alarm_params.merge({user_id: params[:user_id]}))
    if @alarm.save
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

  class Day
    def initialize(id, name)
      @id = id
      @name = name
    end

    def id
      @id
    end

    def name
      @name
    end
  end

  private
  def alarm_params
    params.require(:alarm).permit(:label, :time)
  end
end
