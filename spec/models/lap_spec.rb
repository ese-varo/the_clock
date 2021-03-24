require 'rails_helper'

RSpec.describe Lap, type: :model do
  let(:user) { create(:user) }
  describe 'associations' do
    it { should belong_to(:stopwatch) }
  end

  describe 'validations' do
    it "is valid with a time, difference and stopwatch_id" do
      stopwatch = create(:stopwatch, user: user)
      lap = create(:lap, stopwatch: stopwatch) 
      expect(lap).to be_valid
    end

    it "is invalid without time" do
      lap = build(:lap, time: nil)
      lap.valid?
      expect(lap.errors[:time]).to include("can't be blank")
    end
    
    it "is invalid without difference" do
      lap = build(:lap, time: 1000, difference: nil)
      lap.valid?
      expect(lap.errors[:difference]).to include("can't be blank")
    end
    
    it "is invalid if the stopwatch does not exist" do
      lap = build(:lap, stopwatch_id: 0)
      lap.valid?
      expect(lap).not_to be_valid
    end
  end
end
