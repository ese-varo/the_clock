# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    SummaryNotificationJob.set(wait: 24.hours).perform_later(current_user)
  end
end
