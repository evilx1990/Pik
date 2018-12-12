# frozen_string_literal: true

require 'rails_helper'

describe 'devise/session/new.html.haml', type: :view do
  before do
    visit new_user_session_path
  end

  context 'should be contain' do
    it 'facebook login link' do
      expect(page).to have_selector('#before-login > a > img')
    end

    it 'user email field' do
      expect(page).to have_field('user_email')
    end

    it 'user password field' do
      expect(page).to have_field('user_password')
    end

    it 'remember user checkbox' do
      expect(page).to have_unchecked_field('user_remember_me')
    end

    it 'log in button' do
      expect(page).to have_button('Log in')
    end

    it 'forgot password link' do
      expect(page).to have_link('Forgot your password?')
    end
  end
end