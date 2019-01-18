# frozen_string_literal: true

require 'rails_helper'

describe 'Facebook login', type: :view do
  before(:each) do
    logout(:user)
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  it 'should be create and login user from facebook', driver: :selenium_chrome_headless do
    mock_auth_hash
    visit new_user_session_path
    find('#facebook-button').click
    expect(page).to have_text(OmniAuth.config.mock_auth[:facebook].info.name)
  end
end