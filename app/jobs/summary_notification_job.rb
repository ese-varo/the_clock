class SummaryNotificationJob < ApplicationJob
  queue_adapter = :async
  queue_as :default

  def perform(user)
    reschedule_job(user)
    @user = user 
    AlarmMailer.with(user: @user).summary_email(summary.to_json).deliver_later
  end

  private
  def reschedule_job(user)
    # self.class.set(wait: 24.hours).perform_later(user)
    self.class.set(wait: 25.seconds).perform_later(user)
  end

  def summary
    {
      stopwatches: stopwatches,
      alarms: alarms
    }
  end

  def stopwatches
    @stopwatches ||= @user.stopwatches.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def alarms
    @alarms ||= @user.alarms.where(time: Time.zone.tomorrow.beginning_of_day..Time.zone.tomorrow.end_of_day)
  end
end
