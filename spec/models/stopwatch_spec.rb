require 'rails_helper'

RSpec.describe Stopwatch, type: :model do
  let(:user) do 
    create(:user)
  end
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:laps) }
  end

  describe 'validations' do
    it "is valid with a label and user_id" do
      stopwatch = create(:stopwatch, user: user)
      expect(stopwatch).to be_valid
    end

    it "is invalid without a label" do
      stopwatch = build(:stopwatch, label: nil)
      stopwatch.valid?
      expect(stopwatch.errors[:label]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the user does not exist" do
      stopwatch = build(:stopwatch, user: nil)
      expect(stopwatch).not_to be_valid
    end
  end
end
