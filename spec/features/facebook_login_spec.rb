# frozen_string_literal: true

require 'rails_helper'

describe 'Facebook login', type: :view do
  before(:each) do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  it 'should be create and login user from facebook', driver: :selenium_chrome_headless do
    visit new_user_session_path
    mock_auth_hash
    find('#before-login > a > img').click
    expect(page).to have_content(OmniAuth.config.mock_auth[:facebook].info.name)
    expect(User.count).to eq(1)
  end
end