class AlarmMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def alert_alarm_email
    @user = params[:user]
    @alarm = params[:alarm]
    mail(to: @user.email, subject: 'A new alarm registered')
  end
  
  def summary_email(summary)
    @user = params[:user]
    @summary = ActiveSupport::JSON.decode(summary)
    mail(to: @user.email, subject: 'This is the summary of the day')
  end
end
