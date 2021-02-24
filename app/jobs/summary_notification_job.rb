class SummaryNotificationJob < ApplicationJob
  queue_adapter = :async
  queue_as :default

  def perform(*args)
    AlarmMailer.with(user: args[0]).summary_email.deliver_later
  end
end
