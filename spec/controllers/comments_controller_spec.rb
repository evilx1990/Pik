# frozen_string_literal: true

require 'rails_helper'

describe CommentsController, type: :controller do
  let(:comment) { create(:comment) }

  before do
    @user = create(:user)
    sign_in(@user)
  end

  context 'GET #index' do
    let(:comments) { create_list(:comment, 3) }

    subject! { get :index }

    it 'has a 200 code status' do
      expect(response).to have_http_status(200)
    end

    it 'render the index template' do
      expect(response).to render_template(:index)
    end

    it 'assign @comments' do
      expect(assigns(:comments)) == comments
    end
  end

  context 'POST #create' do
    let(:image) { create(:image) }
    let(:comment) { build(:comment, image: image) }

    subject! do
      post :create,
           params: {
             category_id: image.category.id,
             image_id: image.id,
             comment: {
               body: comment.body
             }
           }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be create new comment' do
      expect(response).to redirect_to category_image_path(id: image.id)
    end
  end
end