class AlarmNotificationJob < ApplicationJob
  queue_adapter = :async
  queue_as :alert_alarm

  def perform(*args)
    AlarmMailer.alert_alarm_email(user: args[0], alarm: args[1]).deliver_now
  end
end
