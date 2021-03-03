class Lap < ApplicationRecord
  belongs_to :stopwatch

  scope :shorter_lap, ->(stopwatch_id) { where(stopwatch_id: stopwatch_id).order('difference ASC').first }
end
