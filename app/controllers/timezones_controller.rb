class TimezonesController < ApplicationController
  def index
    @user_timezones = Timezone.where(user_id: current_user.id) 
    #@user_timezones = timezones.to_a.map { |time| ActiveSupport::TimeZone.new(time.name) }
  end

  def destroy
    @timezone = Timezone.find(params[:id])
    @timezone.destroy
    redirect_to root_path
  end
end
