# frozen_string_literal: true

require 'rails_helper'

describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    session[:login_failure] = 2
  end

  context 'failure captcha check' do
    before do
      allow(controller).to receive(:verify_recaptcha).and_return(false)
      post :create,
           params: {
             'g-recaptcha-response' => '',
             user: {
               email: user.email,
               password: user.password
             }
           }
    end

    it 'should be render the new template' do
      expect(response).to render_template(:new)
    end
  end

  context 'successful check captcha' do
    before do
      allow(controller).to receive(:verify_recaptcha).and_return(true)
      post :create,
           params: {
             'g-recaptcha-response' => '12356',
             user: {
               email: user.email,
               password: user.password
             }
           }
    end

    it 'should be log in user' do
      expect(response).to have_http_status(302)
    end
  end
end