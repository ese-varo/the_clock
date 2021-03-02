class Alarm < ApplicationRecord
  belongs_to :user
  serialize :days, Array

  def format_time
    time.strftime('%I:%M%p')
  end
end
