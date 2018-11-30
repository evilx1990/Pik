# frozen_string_literal: true

require 'rails_helper'

describe CategoriesController, type: :controller do
  let(:category) { create(:category) }

  before do
    @user = create(:user)
    sign_in(@user)
  end

  context 'GET #index' do
    let(:categories) { create_list(:category, 3) }

    before do
      get :index
    end

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assign @categories' do
      expect(assigns(:categories)).to eq categories
    end

    it 'assign @category' do
      expect(assigns(:category)) == Category.new
    end
  end

  context 'GET #show' do
    before do
      get :show, params: { id: category.id }
    end

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'render the show template' do
      expect(response).to render_template(:show)
    end

    it 'assign @images' do
      expect(assigns(:images)).to eq category.images
    end
  end

  context 'POST #create' do
    let(:new_category) { build(:category, name: category.name, user: @user) }

    before do
      post :create,
           params: {
             category: {
               name: new_category.name,
               image_id: nil
             }
           }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be create new category' do
      expect(new_category.save!).to be true
    end

    it 'should be redirect after save' do
      expect(response).to redirect_to(categories_path)
    end

    it 'should be render index after fail' do
      post :create, params: { category: { name: nil } }
      expect(response).to render_template(:index)
    end
  end

  context 'PUT #update' do
    let(:category_image) { create(:category_with_images) }

    before do
      put :update,
          params: {
            id: category_image.id,
            category: {
              name: Faker::FunnyName.name[3..15],
              image_id: category_image.images.first.id
            }
          }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be redirect to category after update' do
      expect(response).to redirect_to(category_image)
    end

    it 'assign @category' do
      expect(assigns(:category)).to eq category_image
    end
  end

  context 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: category.id }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be redirect to categories after delete' do
      expect(response).to redirect_to(categories_path)
    end
  end

  context 'PUT #follow' do
    before do
      put :follow, params: { id: category.id }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be follow on category' do
      expect(response).to redirect_to(categories_path)
    end
  end

  context 'PUT #unfollow' do
    let(:follow) { create(:follow, follower: @user) }

    before do
      put :unfollow, params: { id: follow.followable.id }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be unfollow on category' do
      expect(response).to redirect_to(categories_path)
    end
  end
end
