class Alarm < ApplicationRecord
  belongs_to :user
  serialize :days, Array
end
