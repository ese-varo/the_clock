class StopwatchDecorator < SimpleDelegator
  def display_lap_time
    "#{sprintf("%.2d", (time % (1000 * 60 * 60)) / (1000 * 60))}:#{sprintf("%.2d", (time % (1000 * 60)) / 1000)}"
  end

  def display_lap_difference
    "#{sprintf("%.2d", (difference % (1000 * 60 * 60)) / (1000 * 60))}:#{sprintf("%.2d", (difference % (1000 * 60)) / 1000)}"
  end
end
