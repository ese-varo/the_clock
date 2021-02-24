class AlarmMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def alert_alarm_email
    @user = params[:user]
    @alarm = params[:alarm]
    mail(to: @user.email, subject: 'A new alarm registered')
  end
  
  def summary_email
    @user = params[:user]
    @alarms = @user.alarms
    @stopwatches = @user.stopwatches
    mail(to: @user.email, subject: 'This is the summary of the day')
  end
end
