class AlarmMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def alert_alarm_email
    @user = params[:user]
    @alarm = params[:alarm]
    mail(to: @user.email, subject: 'A new alarm registered')
  end
end
