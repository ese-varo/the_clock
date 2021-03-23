class StopwatchDecorator < SimpleDelegator
  def display_lap_time
    Time.at(time).utc.strftime("%H:%M:%S")
  end

  def display_lap_difference
    Time.at(difference).utc.strftime("%H:%M:%S")
  end
end
