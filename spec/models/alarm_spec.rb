require 'rails_helper'

RSpec.describe Alarm, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it "is valid with a label, time, days and user_id" do
      test_user = User.create( email: 'test@gmail.com', name: 'Test', password: '123456')
      alarm = Alarm.new( label: 'Test morning', time: DateTime.now, days: ['Monday'], user_id: test_user.id)
      expect(alarm).to be_valid
    end

    it "is invalid without a label" do
      alarm = Alarm.new(label: nil)
      alarm.valid?
      expect(alarm.errors[:label]).not_to include(["can't be blank"])
    end
    
    it "is invalid without a time declared" do
      alarm = Alarm.new(time: nil)
      alarm.valid?
      expect(alarm.errors[:time]).not_to include(["can't be blank"])
    end
    
    it "is invalid without a days declared" do
      alarm = Alarm.new(days: nil)
      alarm.valid?
      expect(alarm.errors[:days]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the user does not exist" do
      alarm = Alarm.new( label: 'Test morning', time: DateTime.now, days: ['Monday'], user_id: 0)
      expect(alarm).not_to be_valid
    end
  end
end
