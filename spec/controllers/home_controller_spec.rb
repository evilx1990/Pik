# frozen_string_literal: true

require 'rails_helper'

describe HomeController, type: :controller do
  context 'GET #index' do
    context 'user sign in' do
      before do
        sign_in(create(:user))
        get :index
      end

      it 'has a 302 code status' do
        expect(response).to have_http_status(302)
      end

      it 'should be redirect to categories if user sign_in' do
        expect(response).to redirect_to categories_path
      end
    end

    context 'user do not sign in' do
      it 'should be render the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end