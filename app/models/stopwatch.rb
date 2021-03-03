class Stopwatch < ApplicationRecord
  belongs_to :user
  has_many :laps, dependent: :destroy
end
