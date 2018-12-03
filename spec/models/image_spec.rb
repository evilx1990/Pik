# frozen_string_literal: true

require 'rails_helper'

describe Image, type: :model do
  subject(:image) { FactoryBot.create(:image) }

  context 'validation' do
    it 'should be invalid without image name' do
      expect(build(:image,
                   image_name: nil,
                   picture: image.picture,
                   user_id: image.user_id,
                   category_id: image.category.id)).not_to be_valid
    end

    it 'should be invalid with image name less 3 symbols' do
      expect(build(:image,
                   image_name: 'im',
                   picture: image.picture,
                   user_id: image.user_id,
                   category_id: image.category_id)).not_to be_valid
    end

    it 'should be invalid with image name more 15 symbols' do
      expect(build(:image,
                   image_name: 'image_name_image_name',
                   picture: image.picture,
                   user_id: image.user_id,
                   category_id: image.category_id)).not_to be_valid
    end

    it 'should be invalid without image' do
      expect(build(:image,
                   image_name: image.image_name,
                   picture: nil,
                   user_id: image.user_id,
                   category_id: image.category_id)).not_to be_valid
    end

    it 'should be invalid with image size more 50 mb' do
      expect(build(:image,
                   image_name: image.image_name,
                   picture: File.open("#{Rails.root}/public/Mouse-retina2-full-resolution.jpg"),
                   user_id: image.user_id,
                   category_id: image.category_id)).not_to be_valid
    end

    it 'should be invalid with format different from jpg/jpeg/png' do
      expect(build(:image,
                   image_name: image.image_name,
                   picture: File.open("#{Rails.root}/spec/support/test.bmp"),
                   user_id: image.user_id,
                   category_id: image.category_id)).not_to be_valid
    end
  end

  context 'Association' do
    it 'has many comments' do
      respond_to :comments
    end

    it 'has many votes' do
      respond_to :votes
    end

    it 'has_many likes' do
      respond_to :likes
    end

    it 'has many dislikes' do
      respond_to :dislikes
    end

    it 'belongs to category' do
      respond_to :category
    end

    it 'belongs to user' do
      respond_to :user
    end
  end

  context 'method' do
    describe '#vote_from' do
      let(:user) { create(:user) }

      it 'should be return true with valid parameters' do
        expect(subject.vote_from(user.id, true)).to be_truthy
      end
    end
  end

  context 'counter cache' do
    describe 'comments counter' do
      let(:image) { create(:image_with_comments) }

      it 'should be equal 3' do
        expect(image.comments_count).to eq(3)
      end
    end

    describe 'votes counter' do
      let(:image) { create(:image_with_votes) }

      it 'should be equal 2' do
        expect(image.votes_count).to eq(2)
      end
    end
  end
end