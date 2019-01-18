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

    subject! { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assign @categories' do
      expect(assigns(:categories)) == categories
    end

    it 'assign @category' do
      expect(assigns(:category)) == Category.new
    end
  end

  context 'GET #show' do
    let(:category_images) { create(:category_with_images) }

    subject! { get :show, params: { id: category.slug } }

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
    let(:new_category) { build(:category, user: @user) }

    subject! do
      post :create,
           params: {
             category: {
               name: new_category.name,
               preview: nil
             }
           }
    end

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be create new category' do
      expect(new_category.name).to eq Category.last.name
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

    subject! do
      put :update,
          params: {
            id: category_image.id,
            category: {
              name: Faker::String.random(10),
              preview: nil
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
    subject! { delete :destroy, params: { id: category.id } }

    it 'has a 302 status code' do
      expect(response).to have_http_status(302)
    end

    it 'should be redirect to categories after delete' do
      expect(response).to redirect_to(categories_path)
    end
  end

  context 'PUT #follow' do
    subject! { put :follow, xhr: :js, params: { id: category.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end
  end

  context 'PUT #unfollow' do
    let(:follow) { create(:follow, user: @user) }

    subject! { put :unfollow, xhr: :js, params: { id: follow.category.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(200)
    end
  end
end
