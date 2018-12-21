# frozen_string_literal: true

require 'rails_helper'

describe UserMailer do
  let(:user) { create(:user) }
  let(:url) { 'http://some.url' }

  describe '.welcome_email' do
    let(:mail) { UserMailer.with(user_id: user.id, url: url).welcome_email }

    it 'render the welcome subject' do
      expect(mail.subject).to eq('Welcome Gallery')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'render the sender email' do
      expect(mail.from).to eq(['gallery@example.com'])
    end

    it 'should be send welcome email' do
      mail.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  describe '.follow_email' do
    let(:category) { create(:category) }
    let(:mail) { UserMailer.with(user_id: user.id, category_id: category.id, url: url).follow_email }

    it 'render the follow subject' do
      expect(mail.subject).to eq('Follow')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'render the sender email' do
      expect(mail.from).to eq(['gallery@example.com'])
    end

    it 'should be send follow email' do
      mail.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  describe '.new_image_email' do
    let(:category) { create(:category_with_follows) }
    let(:mail) do
      UserMailer.with(user_id: category.follows.last.user.id,
                      category_id: category.id,
                      url_category: url,
                      url: url).new_image_email
    end

    it 'render the new image subject' do
      expect(mail.subject).to eq('New image')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq([category.follows.last.user.email])
    end

    it 'render the sender email' do
      expect(mail.from).to eq(['gallery@example.com'])
    end

    it 'should be send new image email' do
      mail.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  describe '.share_image' do
    let(:mail) do
      UserMailer.with(email: 'send@some.email',
                    user_id: user.id,
                    url: url,
                    message: Faker::String.random(20)).share_image_email
    end

    it 'render the follow subject' do
      expect(mail.subject).to eq('Hello! Take it look')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq(['send@some.email'])
    end

    it 'render the sender email' do
      expect(mail.from).to eq(['gallery@example.com'])
    end

    it 'should be send share image email' do
      mail.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
