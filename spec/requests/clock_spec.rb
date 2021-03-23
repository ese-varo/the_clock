require 'rails_helper'

RSpec.describe 'Clock', type: :request do
  let(:name) { "Tijuana" }
  let(:user) do 
    create(:user)
  end
  let(:timezone) do
    create(:timezone,
      user: user
    )
  end

  describe "GET #main as a guess user" do
    it "exists and responds" do
      get root_path
      expect(response.status).to eq(200)
    end
  end

  describe "GET #index" do
    it "exists and responds" do
      login_as(user)
      get clock_index_path 
      expect(response).to have_http_status(200)
    end
  end

  describe "GET clock#all_timezones" do
    context "As a not logged in user" do
      it "response with all timezones" do
        get all_timezones_path
        expect(assigns(:timezones)).to eq ActiveSupport::TimeZone.all 
      end
    end

    context "As a logged in user" do
      it "response with all timezones with weather" do
        login_as(user)
        get all_timezones_path
        expect(assigns(:timezones).first).to eq (WeatherSetter.new([ActiveSupport::TimeZone.all.first]).call).first
      end
    end
  end
  
  describe 'GET #show' do
    it "assigns a new timezone to @timezone" do
      get clock_path id: name
      expect(assigns(:timezone)).to eq ActiveSupport::TimeZone.new(name) 
    end

    it "renders the :show template" do
      get clock_path id: name
      expect(response).to render_template :show
    end 
  end

  describe 'GET #edit' do
    it "assigns a requested to @timezone" do
      get edit_clock_path id: name
      expect(assigns(:timezones)).to eq ActiveSupport::TimeZone.all.map {|zone| [zone.name, zone.name]}
    end

    it "renders the :edit template" do
      get edit_clock_path id: name
      expect(response).to render_template :edit
    end 
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "saves the favorite timezone in the database" do
        login_as(user) 
        expect{
          post clock_index_path, params: {name: name}
        }.to change(Timezone, :count).by(1)
      end

      it "redirects to clock#index" do
        login_as(user) 
        post clock_index_path, params: {name: name}
        expect(response).to redirect_to clock_index_path
      end
    end

    context 'with invalid attributes' do 
      it "does not save the favorite timezone in the databse" do 
        login_as(user)
        expect{
          post clock_index_path, params: {name: nil}
        }.not_to change(Timezone, :count)
      end

      it "re-renders the all_timezones template" do
        login_as(user)
        post clock_index_path, params: {name: nil}
        expect(response).to redirect_to all_timezones_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do 
      @user = create(:user, timezone: name)
    end
    context 'with valid attributes' do
      it "locates the requested @contact" do 
        login_as(@user)
        patch clock_path id: @user.id, params: {timezone: name}
        expect(assigns(:current_user)).to eq(@user)
      end

      it "updates the user timezone in the database" do
        login_as(@user)
        patch clock_path id: @user.id, params: {timezone: timezone.name}
        @user.reload
        expect(@user.timezone).to eq(timezone.name)
      end

      it "redirects to the clock#index" do
        login_as(user)
        patch clock_path id: @user.id, params: {timezone: name}
        expect(response).to redirect_to clock_index_path
      end
    end

    context 'with invalid attributes' do
      it "does not update the user timezone" do
        login_as(@user)
        patch clock_path id: @user.id, params: {timezone: nil}
        @user.reload
        expect(@user.timezone).not_to eq(name)
      end

      it "redirects to new template" do
        login_as(user)
        patch clock_path id: @user.id, params: {timezone: nil}
        expect(response).to redirect_to clock_index_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @timezone = create(:timezone)
    end

    it "deletes the timezone from the database" do
      expect {
        delete clock_path id: @timezone
      }.to change(Timezone, :count).by(-1)
    end

    it "redirects to clock#index" do
      delete clock_path id: @timezone
      expect(response).to redirect_to clock_index_path
    end
  end
end
