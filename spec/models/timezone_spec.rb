require 'rails_helper'

RSpec.describe Timezone, type: :model do
  let(:user) do 
    create(:user)
  end
  
  describe 'associations' do
    it { should belong_to(:user) }  
  end

  describe 'validations' do
    it "is valid with a name and user_id" do
      timezone = create(:timezone, user: user)
      expect(timezone).to be_valid
    end

    it "is invalid without a name" do
      timezone = build(:timezone, name: nil)
      timezone.valid?
      expect(timezone.errors[:name]).not_to include(["can't be blank"])
    end
    
    it "is invalid if the user does not exist" do
      timezone = build(:timezone, user: nil)
      expect(timezone).not_to be_valid
    end
  end
end
