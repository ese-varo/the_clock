require 'rails_helper'

RSpec.describe Stopwatch, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:laps) }
  end

  describe 'validations' do
    it "is valid with a label and user_id" do
      test_user = User.create( email: 'test@gmail.com', name: 'Test', password: '123456')
      stopwatch = Stopwatch.new( label: 'Test Time', user_id: test_user.id)
      expect(stopwatch).to be_valid
    end

    it "is invalid without a label" do
      stopwatch = Stopwatch.new(label: nil)
      stopwatch.valid?
      expect(stopwatch.errors[:label]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the user does not exist" do
      stopwatch = Stopwatch.new(label: 'Test Time', user_id: 0)
      expect(stopwatch).not_to be_valid
    end
  end
end
