class Stopwatch < ApplicationRecord
  belongs_to :user
  has_many :laps, dependent: :destroy
  validates :label, presence: true
end
