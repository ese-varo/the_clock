require 'rails_helper'

RSpec.describe Lap, type: :model do
  describe 'associations' do
    it { should belong_to(:stopwatch) }
  end

  describe 'validations' do
    it "is valid with a time, difference and stopwatch_id" do
      user = User.create( email: 'test@gmail.com', name: 'Test', password: '123456')
      stopwatch = Stopwatch.create( label: 'Test', user_id: user.id )
      lap = Lap.new( time: 3020, difference: 1020, stopwatch_id: stopwatch.id)
      expect(lap).to be_valid
    end

    it "is invalid without time" do
      lap = Lap.new(time: nil, difference: 1000)
      lap.valid?
      expect(lap.errors[:time]).not_to include(["can't be blank"])
    end
    
    it "is invalid without difference" do
      lap = Lap.new(time: 1000, difference: nil)
      lap.valid?
      expect(lap.errors[:difference]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the stopwatch does not exist" do
      lap = Lap.new(time: 1000, difference: 1000, stopwatch_id: 0)
      expect(lap).not_to be_valid
    end
  end
end
