require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'POST #create' do
    context 'with valid attributes' do
      it "sign up on application" do
        expect{
          post user_registration_path, params: {user: attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "redirects to alarm#index" do
        post user_registration_path, params: {user: attributes_for(:user)}
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do 
      it "does not save the alarm in the databse" do 
        expect{
          post user_registration_path, params: {user: attributes_for(:user, email:nil)}
        }.not_to change(User, :count)
      end
    end
  end
end
