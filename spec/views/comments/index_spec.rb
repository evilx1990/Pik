# frozen_string_literal: true

require 'rails_helper'

describe 'comments/index.html.haml', type: :view do
  let (:comment) { create(:comment) }

  before do
    comment
    login_as(comment.user, scope: :user)
    visit comments_path
  end

  it 'has a request.fullpath that is defined' do
    expect(controller.request.fullpath).to eq(comments_path)
  end

  context 'should be contain users comment' do
    it 'user avatar' do
      expect(page).to have_selector('#comment > img')
    end

    it 'username' do
      expect(page).to have_selector('#uname')
    end

    it 'publication date' do
      expect(page).to have_selector('#date')
    end

    it 'comment body' do
      expect(page).to have_selector('#body')
    end
  end
end