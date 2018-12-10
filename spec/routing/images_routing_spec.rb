# frozen_string_literal: true

require 'rails_helper'

describe 'Routing to images', type: :routing do
  let(:image) { create(:image) }

  context 'should be routes' do
    it '/images to images#index' do
      expect(get: '/images').to route_to(controller: 'images',
                                         action: 'index')
    end

    it '/images/:id to images#show' do
      expect(get: "categories/#{image.category.slug}/images/#{image.slug}").to route_to(controller: 'images',
                                                                                        action: 'show',
                                                                                        category_id: image.category.slug,
                                                                                        id: image.slug)
    end

    it '/categories/:category_id/images/new to images#new' do
      expect(get: "categories/#{image.category.slug}/images/new").to route_to(controller: 'images',
                                                                              action: 'new',
                                                                              category_id: image.category.slug)
    end

    it '/categories/:category_id/images to images#create' do
      expect(post: "/categories/#{image.category.slug}/images").to route_to(controller: 'images',
                                                                            action: 'create',
                                                                            category_id: image.category.slug)
    end

    it '/categories/:category_id/images/:id/like to images#like' do
      expect(put: "/categories/#{image.category.slug}/images/#{image.slug}/like").to route_to(controller: 'images',
                                                                                              action: 'like',
                                                                                              category_id: image.category.slug,
                                                                                              id: image.slug)
    end

    it '/categories/:category_id/images/:id/like to images#dislike' do
      expect(put: "/categories/#{image.category.slug}/images/#{image.slug}/dislike").to route_to(controller: 'images',
                                                                                                 action: 'dislike',
                                                                                                 category_id: image.category.slug,
                                                                                                 id: image.slug)
    end

    it '/categories/:category_id/images/:id/like to images#download' do
      expect(get: "categories/#{image.category.slug}/images/#{image.slug}/download").to route_to(controller: 'images',
                                                                                                 action: 'download',
                                                                                                 category_id: image.category.slug,
                                                                                                 id: image.slug)
    end
  end

  context 'should not be routes' do
    it '/categories/:category_id/images/:id/edit to images#edit' do
      expect(get: "categories/#{image.category.slug}/images/#{image.slug}/edit").not_to route_to(controller: 'images',
                                                                                                 action: 'edit',
                                                                                                 category_id: image.category.slug)
    end

    it '/categories/:category_id/images/:id to images#update' do
      expect(put: "categories/#{image.category.slug}/images/#{image.slug}").not_to route_to(controller: 'images',
                                                                                            action: 'update',
                                                                                            category_id: image.category.slug)
    end

    it '/categories/:category_id/images/:id to images#destroy' do
      expect(delete: "categories/#{image.category.slug}/images/#{image.slug}").not_to route_to(controller: 'images',
                                                                                               action: 'destroy',
                                                                                               category_id: image.category.slug,
                                                                                               id: image.slug)
    end
  end
end