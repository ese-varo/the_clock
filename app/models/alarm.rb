class Alarm < ApplicationRecord
  belongs_to :user
  has_many :alarmDays, dependent: :destroy
end
