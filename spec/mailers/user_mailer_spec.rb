# frozen_string_literal: true

require 'rails_helper'

describe UserMailer do
  let(:user) { create(:user) }

  describe '.welcome_email' do
    let(:mail) { UserMailer.with(user: user).welcome_email }

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
    let(:mail) { UserMailer.with(user: user, category: category.slug).follow_email }

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
      UserMailer.with(user: category.follows.first.user,
                      category: category.slug).new_image_email
    end

    it 'render the new image subject' do
      expect(mail.subject).to eq('New image')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq([category.follows.first.user.email])
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
      UserMailer.with(email: user.email,
                      url: Faker::Internet.url,
                      message: Faker::String.random(20)).share_image_email
    end

    it 'render the follow subject' do
      expect(mail.subject).to eq('Hello! Take it look')
    end

    it 'render the receiver email' do
      expect(mail.to).to eq([user.email])
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
