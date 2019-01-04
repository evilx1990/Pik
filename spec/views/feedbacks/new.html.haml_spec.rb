# frozen_string_literal: true

require 'rails_helper'

describe 'feedbacks/new.html.haml', type: :view do
  let(:feedback) { create(:feedback) }

  before do
    visit new_feedback_path
  end

  it 'has a request.fullpath that is defined' do
    expect(controller.request.fullpath).to eq(new_feedback_path)
  end

  context 'render partial' do
    it 'the feedbacks/form template' do
      expect(page).to render_template(partial: 'feedbacks/_form')
    end
  end

  context 'should be contain create feedback form' do
    it 'email field' do
      expect(page).to have_field('feedback_email_author')
    end

    it 'username field' do
      expect(page).to have_field('feedback_name')
    end

    it 'feedback field' do
      expect(page).to have_field('feedback_feedback')
    end

    it 'create feedback button' do
      expect(page).to have_button('Send')
    end
  end
end