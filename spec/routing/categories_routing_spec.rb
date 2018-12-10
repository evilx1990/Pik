# frozen_string_literal: true

require 'rails_helper'

describe 'Routing to category', type: :routing do
  let(:category) { create(:category) }

  context 'should be routes' do
    it '/categories to categories#index' do
      expect(get: '/categories').to route_to(controller: 'categories', action: 'index')
    end

    it '/categories/:id to categories#show' do
      expect(get: "/categories/#{category.slug}").to route_to(controller: 'categories',
                                                              action: 'show',
                                                              id: category.slug)
    end

    it '/categories to categories#create' do
      expect(post: '/categories'). to route_to(controller: 'categories', action: 'create')
    end

    it '/categories/:id to categories#update' do
      expect(put: "/categories/#{category.slug}").to route_to(controller: 'categories',
                                                              action: 'update',
                                                              id: category.slug)
    end

    it '/categories/:id to categories#destroy' do
      expect(delete: "categories/#{category.slug}").to route_to(controller: 'categories',
                                                                action: 'destroy',
                                                                id: category.slug)
    end

    it '/categories/:id/follow to categories#follow' do
      expect(put: "categories/#{category.slug}/follow").to route_to(controller: 'categories',
                                                                    action: 'follow',
                                                                    id: category.slug)
    end

    it '/categories/:id/unfollow to categories#unfollow' do
      expect(put: "categories/#{category.slug}/unfollow").to route_to(controller: 'categories',
                                                                      action: 'unfollow',
                                                                      id: category.slug)
    end
  end

  context 'should not be routes' do
    it '/categories/new to categories#new' do
      expect(get: 'categories/new').not_to route_to(controller: 'categories',
                                                    action: 'new')
    end

    it '/categories/:id/edit to categories#edit' do
      expect(get: "categories/#{category.slug}/edit").not_to be_routable
    end
  end
end
