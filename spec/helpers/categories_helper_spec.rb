# frozen_string_literal: true

require 'rails_helper'

describe CategoriesHelper, type: :helper do
  let(:categories) { create_list(:category_with_img_cmnt_fllw, 5) }

  describe '#categories_zero?' do
    it 'should be return true if categories list empty' do
      expect(helper.categories_zero?).to be_truthy
    end

    it 'should be return false if categories list not empty' do
      categories
      expect(helper.categories_zero?).to be_falsey
    end
  end

  describe '#get_top_categories' do
    before do
      categories.last.name = 'last_category'
      categories.last.save
      categories.last.images.first.comments.create(body: 'Hello!', user: create(:user))
    end

    it 'should be returned valid top categories' do
      expect(helper.get_top_categories(5).first.name).to eq('last_category')
    end
  end
end