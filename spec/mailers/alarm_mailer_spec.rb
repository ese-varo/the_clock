require "rails_helper"

RSpec.describe AlarmMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:alarm) { create(:alarm, user: user) }
  describe "alert alarm mailer" do
    context "headers" do
      it "renders the subject" do
        mail = described_class.alert_alarm_email(user, alarm)
        expect(mail.subject).to eq I18n.t("alarm_mailer.alert_alarm_email.subject")
      end

      it "sends to the right email" do
        mail = described_class.alert_alarm_email(user, alarm)
        expect(mail.to).to eq [user.email]
      end

      it "renders the from email" do
        mail = described_class.alert_alarm_email(user, alarm)
        expect(mail.from).to eq ["notifications@example.com"]
      end
    end
  end
  
  describe "summary mailer" do
    before :each do
      5.times { create(:stopwatch, user: user) }
      5.times { create(:alarm, user: user) }
      @summary = {stopwatches: user.stopwatches, alarms: user.alarms}
    end
    context "headers" do
      it "renders the subject" do
        mail = described_class.summary_email(user, @summary)
        expect(mail.subject).to eq I18n.t("alarm_mailer.summary_email.subject")
      end

      it "sends to the right email" do
        mail = described_class.summary_email(user, @summary)
        expect(mail.to).to eq [user.email]
      end

      it "renders the from email" do
        mail = described_class.summary_email(user, @summary)
        expect(mail.from).to eq ["notifications@example.com"]
      end
    end
  end
end
