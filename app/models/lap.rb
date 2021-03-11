class Lap < ApplicationRecord
  belongs_to :stopwatch
  validates :time, :difference, presence: true
  scope :shorter_lap, ->(stopwatch_id) { where(stopwatch_id: stopwatch_id).order('difference ASC').first }
end
