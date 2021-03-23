require 'rails_helper'

RSpec.describe SummaryNotificationJob, type: :job do
  let(:user) do
    create(:user)
  end

  describe "#perfom" do
    it "calls on the AlarmMailer#summary_email" do
      login_as(user)
      allow(AlarmMailer).to receive_message_chain(:summary_email, :deliver_now)
      described_class.new.perform(user)
      expect(AlarmMailer).to have_received(:summary_email)
    end
  end
end
