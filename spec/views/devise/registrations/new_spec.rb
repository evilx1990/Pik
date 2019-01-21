# frozen_string_literal: true

require 'rails_helper'

describe 'devise/registration/new.html.haml', type: :view, driver: :selenium_chrome_headless do
  before do
    visit new_user_registration_path
  end

  context 'should be contain' do
    it 'facebook login link' do
      expect(page).to have_selector('#facebook-button')
    end

    it 'user name field' do
      expect(page).to have_field('user_username')
    end

    it 'user email field' do
      expect(page).to have_field('user_email')
    end

    it 'user password field' do
      expect(page).to have_field('user_password')
    end

    it 'user password confirmation field' do
      expect(page).to have_field('user_password_confirmation')
    end

    it 'recaptcha' do
      expect(page).to have_selector('#recaptcha')
    end

    it 'sign up button' do
      expect(page).to have_button('Sign up')
    end
  end
end