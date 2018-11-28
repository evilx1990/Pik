#frozen_sting_literal: true

require 'rails_helper'

describe ImagesController, type: :controller do
  let(:image) { create(:image) }

  before do
    @user = create(:user)
    sign_in(@user)
  end

  context 'GET #index' do
    let(:images) { create_list(:image, 3) }

    before do
      get :index
    end

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'render the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigment @images' do
      expect(assigns(:images)).to eq images
    end
  end
end
