# frozen_string_literal: true

require 'rails_helper'

describe Category, type: :model do

  context 'validation' do
    subject!(:category) { create(:category) }

    context 'should be invalid' do
      it 'without an name' do
        expect(build(:category, name: nil)).not_to be_valid
      end

      it 'with name less 3 symbols' do
        expect(build(:category, name: 'ca')).not_to be_valid
      end

      it 'with more 15 symbols' do
        expect(build(:category, name: 'categoryName_categoryName')).not_to be_valid
      end

      it 'with a duplicate name' do
        expect(build(:category, name: subject.name)).not_to be_valid
      end
    end

    context 'successful validate' do
      it 'must be save to data base' do
        expect(Category.count).to eq(1)
      end
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
  end

  describe 'counter cache' do
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

  describe 'dependent: destroy' do
    let(:category_images) { create(:category_with_images) }
    let(:category_follow) { create(:category_with_follows) }

    it 'should be destroy all related images' do
      category_images.destroy
      expect(Image.count).to eq(0)
    end

    it 'should be destroy all related follows' do
      category_follow.destroy
      expect(Follow.count).to eq(0)
    end
  end
end
