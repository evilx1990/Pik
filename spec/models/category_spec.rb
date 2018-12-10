# frozen_string_literal: true

require 'rails_helper'

describe Category, type: :model do
  subject(:category) { create(:category) }

  context 'validation' do
    it 'should be invalid without an name' do
      expect(build(:category, name: nil)).not_to be_valid
    end

    it 'should be invalid with name less 3 symbols' do
      expect(build(:category, name: 'ca')).not_to be_valid
    end

    it 'should be invalid with more 15 symbols' do
      expect(build(:category, name: 'categoryName_categoryName')).not_to be_valid
    end
  end

  context 'association' do
    it 'has many images' do
      expect(Category.reflect_on_association(:images).macro).to eq(:has_many)
    end

    it 'has many follows' do
      expect(Category.reflect_on_association(:follows).macro).to eq(:has_many)
    end

    it 'belongs to user' do
      expect(Category.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to image(for preview)' do
      expect(Category.reflect_on_association(:image).macro).to eq(:belongs_to)
    end
  end

  context 'counter cache' do
    describe 'images counter' do
      let(:category) { create(:category_with_images) }

      it 'should be equal 3' do
        expect(category.images_count).to eq 3
      end
    end

    describe 'follows counter' do
      let(:category) { create(:category_with_follows) }

      it 'should be equal 3' do
        expect(category.follows_count).to eq 3
      end
    end
  end
end
