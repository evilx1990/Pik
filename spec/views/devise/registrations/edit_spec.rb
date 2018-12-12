# frozen_string_literal: true

require 'rails_helper'

describe 'devise/registration/edit.html.haml', type: :view do
  before do
    login_as(create(:user_with_avatar), scope: :user)
    visit edit_user_registration_path
  end

  context 'should be contain' do
    it 'user avatar' do
      expect(page).to have_selector('#edit_user > img')
    end

    it 'upload avatar field' do
      expect(page).to have_field('user_avatar')
    end

    context 'if avatar present' do
      it "checkbox 'Remove avatar'" do
        expect(page).to have_content('Remove avatar')
        expect(page).to have_unchecked_field('user_remove_avatar')
      end
    end

    it 'user email field' do
      expect(page).to have_field('user_email')
    end

    it 'user name field' do
      expect(page).to have_field('user_username')
    end

    it 'user new password field' do
      expect(page).to have_field('user_password')
    end

    it 'user confirm password field' do
      expect(page).to have_field('user_password_confirmation')
    end

    it "button 'Update'" do
      expect(page).to have_button('Update')
    end

    it "link 'Remove account'" do
      expect(page).to have_link('Remove account')
    end
  end
end
