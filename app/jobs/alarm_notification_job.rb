class AlarmNotificationJob < ApplicationJob
  queue_adapter = :async
  queue_as :default

  def perform(*args)
    AlarmMailer.with(user: args[0], alarm: args[1]).alert_alarm_email.deliver_later
    puts "La alarma esta sonando"
  end
end
