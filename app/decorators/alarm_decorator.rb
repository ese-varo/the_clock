require_relative 'base_decorator'
class AlarmDecorator < BaseDecorator
  def display_time
    time.strftime('%H:%M%p')
  end
end
