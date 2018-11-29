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

    it 'assign @images' do
      expect(assigns(:images)).to eq images
    end
  end

  context 'GET #show' do
    let(:image) { create(:image_with_comments) }

    before do
      get :show, params: { category_id: image.category.slug, id: image.slug }
    end

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'render the index template' do
      expect(response).to render_template(:show)
    end

    it 'assign @comments' do
      expect(assigns(:comments)). to eq image.comments.order(created_at: :desc)
    end
  end

  context 'GET #new' do
    let(:category) { create(:category) }

    before do
      get :new, xhr: :js, params: { category_id: category.slug }
    end

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'render the new template' do
      expect(response).to render_template(:new)
    end

    it 'assign @image' do
      expect(assigns(:image)) == Image.new
    end
  end

  context 'POST #create' do
    let(:category) { create(:category) }
    let(:image) { build(:image) }

    before do
      post :create,
           params: {
             category_id: category.slug,
             image: {
               picture: fixture_file_upload('spec/support/test.jpg'),
               image_name: image.image_name
             }
           }
    end

    it 'has a 302 code status' do
      expect(response).to have_http_status(302)
    end

    it 'should be create new image' do
      expect(response).to redirect_to category_path(category.slug)
    end
  end

  context 'GET #download' do
    it 'has a 200 code status' do
      get :download,
          params: {
              id: image.id,
              category_id: image.category.id
          }
      expect(response).to have_http_status(200)
    end
  end

  context 'GET #share' do
    before do
      get :share,
          params: {
            category_id: image.category.slug,
            id: image.slug,
            share: {
              url: Faker::Internet.url,
              email: Faker::Internet.email,
              messege: Faker::String.random
            }
          }
    end

    it 'has a 302 code status' do
      expect(response).to have_http_status(302)
    end

    it 'should be shared images' do
      expect(response).to redirect_to category_image_path(category_id: image.category.slug, id: image.slug)
    end
  end

  context 'PUT #like' do
    let(:image_like) { create(:image_with_like, user: @user) }

    it 'has a 302 code status' do
      put :like, params: { category_id: image.category.slug, id: image.slug }
      expect(response).to have_http_status(302)
    end

    it 'should be put like' do
      put :like, params: { category_id: image.category.slug, id: image.slug }
      expect(Vote.last).to eq image.likes.last
    end

    it 'should be remove like' do
      put :like, params: { category_id: image_like.category.slug, id: image_like.slug }
      expect(Vote.last.flag).to eq nil
    end
  end

  context 'PUT #dislike' do
    let(:image_dislike) { create(:image_with_dislike, user: @user) }

    it 'has a 302 code status' do
      put :dislike, params: { category_id: image.category.slug, id: image.slug }
      expect(response).to have_http_status(302)
    end

    it 'should be put dislike' do
      put :dislike, params: { category_id: image.category.slug, id: image.slug }
      expect(Vote.last).to eq image.dislikes.last
    end

    it 'should be remove dislike' do
      put :dislike, params: { category_id: image_dislike.category.slug, id: image_dislike.slug }
      expect(Vote.last.flag).to eq nil
    end
  end
end
