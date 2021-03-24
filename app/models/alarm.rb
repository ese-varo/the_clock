class Alarm < ApplicationRecord
  belongs_to :user
  serialize :days, Array
  validates :days, presence: true, on: :create
  validates :label, presence: true
  validates :time, presence: true
end
