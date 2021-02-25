class Stopwatch < ApplicationRecord
  after_find :change_data
  belongs_to :user

  private
  def change_data
    self.time = "#{sprintf("%.2d", (time.to_i % (1000 * 60 * 60)) / (1000 * 60))}:#{sprintf("%.2d", (time.to_i % (1000 * 60)) / 1000)}"
  end
end
