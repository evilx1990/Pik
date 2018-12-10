# frozen_string_literal: true

require 'rails_helper'

describe 'Routing to comments' do
  let(:comment) { create(:comment) }

  context 'should be routes' do
    it '/comments to comments#index' do
      expect(get: '/comments').to route_to(controller: 'comments', action: 'index')
    end

    it 'categories/:category_id/images/:image_id/comments to categories#create' do
      expect(post: "/categories/#{comment.image.category.slug}/images/#{comment.image.slug}/comments"). to route_to(controller: 'comments',
                                                                                                                    action: 'create',
                                                                                                                    category_id: comment.image.category.slug,
                                                                                                                    image_id: comment.image.slug)
    end
  end

  context 'should not be routes' do
    it 'categories/:category_id/images/:image_id/comments/:id to comments#show' do
      expect(get: "categories/#{comment.image.category.slug}/images/#{comment.image.slug}/comments/#{comment.id}").not_to be_routable
    end

    it '/categories/new to categories#new' do
      expect(get: "categories/#{comment.image.category.slug}/images/#{comment.image.slug}/comments/new").not_to be_routable
    end
    it '/categories/:id/edit to categories#edit' do
      expect(get: "categories/#{comment.image.category.slug}/images/#{comment.image.slug}/comments/#{comment.id}/edit").not_to be_routable
    end

    it '/categories/:id to categories#update' do
      expect(put: "categories/#{comment.image.category.slug}/images/#{comment.image.slug}/comments/#{comment.id}").not_to be_routable
    end


  end
end