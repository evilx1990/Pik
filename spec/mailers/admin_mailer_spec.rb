require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  let(:feedback) { create(:feedback) }
  let(:url) { 'http://test.com' }

  describe '.reply_feedback_email' do
    let(:mail) { AdminMailer.with(email: feedback.email_author,
                                  name: feedback.name,
                                  url: url,
                                  message: Faker::String.random[1..10]).reply_feedback_email }

    it 'render the welcome subject' do
      expect(mail.subject).to eq('Response to your feedback')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq([feedback.email_author])
    end

    it 'render the sender email' do
      expect(mail.from).to eq(['gallery@example.com'])
    end

    it 'should be send welcome email' do
      mail.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
