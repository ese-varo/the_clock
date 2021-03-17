require 'rails_helper'

RSpec.describe Timezone, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }  
  end

  describe 'validations' do
    it "is valid with a name and user_id" do
      test_user = User.create( email: 'test@gmail.com', name: 'Test', password: '123456')
      timezone = Timezone.new(name: 'Test Time', user_id: test_user.id)
      expect(timezone).to be_valid
    end

    it "is invalid without a name" do
      timezone = Timezone.new(name: nil)
      timezone.valid?
      expect(timezone.errors[:name]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the user does not exist" do
      timezone = Timezone.new(name: 'Test Time', user_id: 0)
      expect(timezone).not_to be_valid
    end
  end
end
