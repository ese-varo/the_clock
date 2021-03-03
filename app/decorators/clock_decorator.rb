class ClockDecorator < SimpleDelegator
  def display_timezone
    now.strftime('%F %T%:zUTC')
  end
end
