# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  context 'validations' do
    subject!(:comment) { create(:comment) }

    context 'should be invalid ' do
      it 'without body' do
        expect(build(:comment,
                     body: nil,
                     user_id: comment.user_id,
                     image_id: comment.image_id)).not_to be_valid
      end
    end

    context 'successful validate' do
      it 'must be save to data base' do
        expect(Comment.count).to eq(1)
      end
    end
  end

  context 'association' do
    it 'belongs to image' do
      expect(Comment.reflect_on_association(:image).macro).to eq(:belongs_to)
    end

    it 'belongs to user' do
      expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end