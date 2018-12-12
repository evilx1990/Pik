# frozen_string_literal: true

require 'rails_helper'

describe 'Routing to comments', type: :routing do
  let(:comment) { create(:comment) }

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