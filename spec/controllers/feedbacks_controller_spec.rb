#frozen_string_literal: true

require 'rails_helper'

describe FeedbacksController, type: :controller do
  let(:feedback) { create(:feedback) }

  describe 'GET #new' do
    subject! { get :new }

    it 'has a 200 code status' do
      expect(response).to have_http_status(200)
    end

    it 'render the new template' do
      expect(response).to render_template(:new)
    end

    it 'assign @feedback' do
      expect(assigns(:feedback)) == Feedback.new
    end

    context 'with user login' do
      before do
        @user = create(:user)
        @feedback = Feedback.new(email_author: @user.email, name: @user.username)
        login_as(@user, scope: :user)
      end

      it 'new feedback relation must contain user email end username' do
        expect(assigns(:feedback)) == @feedback
      end
    end
  end

  describe 'GET #create' do
    let(:feedback) { build(:feedback) }

    subject! do
      post :create,
          params: {
            feedback: {
              email_author: feedback.email_author,
              name: feedback.name,
              feedback: feedback.feedback
            }
          }
    end

    it 'has a 302 code status' do
      expect(response).to have_http_status(302)
    end

    it 'should be create new feedback' do
      expect(Feedback.count).to eq 1
    end

    it 'should be have flash[:notice] message' do
      expect(subject.request.flash[:notice]).to be_truthy
    end

    context 'recaptcha fail' do
      subject! do
        allow(controller).to receive(:verify_recaptcha) { false }

        post :create,
             params: {
                 feedback: {
                     email_author: feedback.email_author,
                     name: feedback.name,
                     feedback: feedback.feedback
                 }
             }
      end

      it 'should be have flash[:alert] message' do
        expect(subject.request.flash[:alert]).to be_truthy
      end
    end
  end
end
