require 'rails_helper'

RSpec.describe "Alarms", type: :request do
  let(:user) do 
    create(:user)
  end
  describe "GET #index" do
    it "exists and responds" do
      login_as(user)
      get alarms_path
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it "assigns a new Alarm to @alarm" do
       get new_alarm_path
       expect(assigns(:alarm)).to be_a_new(Alarm)
    end

    it "renders the :new template" do
      get new_alarm_path
      expect(response).to render_template :new
    end
  end
  
  describe 'GET #edit' do
    it "assigns a requested to @timezone" do
      login_as(user)
      alarm = create(:alarm, user: user)
      get edit_alarm_path id: alarm
      expect(assigns(:alarm)).to eq alarm
      expect(assigns(:user)).to eq user
    end

    it "renders the :edit template" do
      login_as(user)
      alarm = create(:alarm)
      get edit_alarm_path id: alarm
      expect(response).to render_template :edit
    end 
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "saves the alarm in the database" do
        login_as(user) 
        expect{
          post alarms_path, params: {alarm: attributes_for(:alarm)}
        }.to change(Alarm, :count).by(1)
      end

      it "redirects to alarm#index" do
        login_as(user) 
        post alarms_path, params: {alarm: attributes_for(:alarm)}
        expect(response).to redirect_to alarms_path
      end
    end

    context 'with invalid attributes' do 
      it "does not save the alarm in the databse" do 
        login_as(user)
        expect{
          post alarms_path, params: {alarm: attributes_for(:alarm, days:nil)}
        }.not_to change(Alarm, :count)
      end

      it "re-renders the :new template" do
        login_as(user)
        post alarms_path, params: {alarm: attributes_for(:alarm, days:nil)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do 
      @alarm = create(:alarm, user: user, days: ['Tuesday'])
    end
    context 'with valid attributes' do
      it "locates the requested @contact" do 
        login_as(user)
        patch alarm_path id: @alarm, params: {alarm: attributes_for(:alarm)}
        expect(assigns(:alarm)).to eq(@alarm)
      end

      it "updates the alarm in the database" do
        login_as(@user)
        patch alarm_path id: @alarm, params: {alarm: attributes_for(:alarm, label: 'TestTime', days: ['Monday']) }
        @alarm.reload
        expect(@alarm.label).to eq('TestTime')
        expect(@alarm.days).to eq(['Monday'])
      end

      it "redirects to the alarm#index" do
        login_as(user)
        patch alarm_path id: @alarm, params: {alarm: attributes_for(:alarm)}
        expect(response).to redirect_to alarms_path
      end
    end

    context 'with invalid attributes' do
      it "does not update the alarm" do
        login_as(user)
        patch alarm_path id: @alarm, params: {alarm: attributes_for(:alarm, label: 'NewTime', time: nil, days: [])}
        @alarm.reload
        expect(@alarm.label).not_to eq('NewTime')
        expect(@alarm.days).to eq(['Tuesday'])
      end

      it "redirects to new template" do
        login_as(user)
        patch alarm_path id: @alarm, params: {alarm: attributes_for(:alarm, label: nil, time: nil)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @alarm = create(:alarm)
    end

    it "deletes the timezone from the database" do
      expect {
        delete alarm_path id: @alarm
      }.to change(Alarm, :count).by(-1)
    end

    it "redirects to alarm#index" do
      delete alarm_path id: @alarm
      expect(response).to redirect_to alarms_path
    end
  end

  describe 'Decorators' do
    it "evaluate alarm decorator to display time" do
      alarm = create(:alarm, time: '10:30')
      expect(AlarmDecorator.new(alarm).display_time).to eq "10:30AM"
    end
  end
end

