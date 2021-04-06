class AlarmMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def alert_alarm_email(user, alarm)
    @user = user
    @alarm = alarm
    mail(to: @user.email)
  end
  
  def summary_email(user, summary)
    @user = user
    @summary = summary 
    mail(to: @user.email)
  end
end
