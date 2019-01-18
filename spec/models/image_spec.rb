# frozen_string_literal: true

require 'rails_helper'

describe Image, type: :model do
  context 'validation' do
    subject!(:image) { create(:image) }

    context 'should be invalid' do
      it 'without image name' do
        expect(build(:image,
                     name: nil,
                     picture: image.picture,
                     user: image.user,
                     category: image.category)).not_to be_valid
      end

      it 'without image' do
        expect(build(:image,
                     name: image.name,
                     picture: nil,
                     user: image.user,
                     category: image.category)).not_to be_valid
      end

      it 'with image size more 50 mb' do
        expect(build(:image,
                     name: image.name,
                     picture: File.open("#{Rails.root}/spec/support/test_more_50_mb_image.jpg"),
                     user: image.user,
                     category: image.category)).not_to be_valid
      end

      it 'with format different from jpg/jpeg/png' do
        expect(build(:image,
                     name: image.name,
                     picture: File.open("#{Rails.root}/spec/support/test.bmp"),
                     user: image.user,
                     category: image.category)).not_to be_valid
      end
    end

    context 'successful validate' do
      it 'must be save to data base' do
        expect(Image.count).to eq(1)
      end
    end
  end

  context 'Association' do
    it 'has many comments' do
      expect(Image.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'has many votes' do
      expect(Image.reflect_on_association(:votes).macro).to eq(:has_many)
    end

    it 'has many likes' do
      expect(Image.reflect_on_association(:likes).macro).to eq(:has_many)
    end

    it 'has many dislikes' do
      expect(Image.reflect_on_association(:dislikes).macro).to eq(:has_many)
    end

    it 'belongs to category' do
      expect(Image.reflect_on_association(:category).macro).to eq(:belongs_to)
    end

    it 'belongs to user' do
      expect(Image.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  context 'method' do
    describe '#vote_from' do
      let(:user) { create(:user) }

      it 'should be return true with valid parameters' do
        expect(subject.vote_from(user, true)).to be_truthy
      end
    end
  end

  describe 'counter cache' do
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

  describe 'dependent: destroy' do
    let(:image_comments) { create(:image_with_comments)}
    let(:image_votes) { create(:image_with_votes)}

    it 'should be destroy all related comments' do
      image_comments.destroy
      expect(Comment.count).to eq(0)
    end

    it 'should be destroy all related votes' do
      image_votes.destroy
      expect(Vote.count).to eq(0)
    end
  end
end