require 'rails_helper'

RSpec.describe AlarmNotificationJob, type: :job do
  let(:user) do
    create(:user)
  end

  describe "#perfom" do
    it "calls on the AlarmMailer" do
      login_as(user)
      alarm = create(:alarm)
      allow(AlarmMailer).to receive_message_chain(:alert_alarm_email, :deliver_now)
      described_class.new.perform(user, alarm)
      expect(AlarmMailer).to have_received(:alert_alarm_email)
    end
  end
end
