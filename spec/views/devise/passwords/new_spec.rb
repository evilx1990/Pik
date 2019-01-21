# frozen_string_literal: true

require 'rails_helper'

describe 'devise/passwords/new.html.haml', type: :view, driver: :selenium_chrome_headless do
  before do
    visit new_user_password_path
  end

  context 'should be contain' do
    it 'email field' do
      expect(page).to have_field('user_email')
    end

    it '<Send instruction button>' do
      expect(page).to have_button('Send instruction')
    end
  end
end