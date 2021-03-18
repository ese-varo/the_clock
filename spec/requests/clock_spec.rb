require 'rails_helper'

RSpec.describe ClockController do
  let(:name) { "Alaska" }
  let(:user) do 
    create(:user)
  end
  let(:timezone) do
    create(:timezone,
      user: user
    )
  end
  # login_user
  let(:valid_session) { {} }

  describe "GET #main as a guess user" do
    it "exists and responds" do
      get '/'
      expect(response.status).to eq(200)
      # expect(response).to have_http_status(:success)
    end
  end

  # describe "GET #index" do
  #   it "exists and responds" do
  #     user
  #     binding.pry
  #     get '/clock', session: valid_session
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe 'GET #show' do
    it "assigns a new timezone to @timezone" do
      get '/clock', params: {id: 'Tijuana'}
      expect(assigns(:timezone)).to eq timezone 
    end

    it "renders the :show template" do
      get '/clock', params: {id: 'Tijuana'}
      expect(response).to render_template :show
    end 
  end
end
