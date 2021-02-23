class SummaryNotificationJob < ApplicationJob
  queue_adapter = :async
  queue_as :default

  def perform(*args)
    AlarmMailer.with(user: args[0], alarm: args[1], stopwatch:args[2]).summary_email.deliver_later
  end
end
