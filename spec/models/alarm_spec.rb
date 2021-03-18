require 'rails_helper'

RSpec.describe Alarm, type: :model do
  let(:user) do 
    create(:user)
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it "is valid with a label, time, days and user_id" do
      alarm = create(:alarm, user: user)
      expect(alarm).to be_valid
    end

    it "is invalid without a label" do
      alarm = build(:alarm, label: nil)
      alarm.valid?
      expect(alarm.errors[:label]).not_to include(["can't be blank"])
    end
    
    it "is invalid without a time declared" do
      alarm = build(:alarm, time: nil)
      alarm.valid?
      expect(alarm.errors[:time]).not_to include(["can't be blank"])
    end
    
    it "is invalid without a days declared" do
      alarm = build(:alarm, days: nil)
      alarm.valid?
      expect(alarm.errors[:days]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the user does not exist" do
      alarm = build(:alarm, user: nil)
      expect(alarm).not_to be_valid
    end
  end
end
