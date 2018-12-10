# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  subject(:comment) { create(:comment) }

  context 'validation' do
    it 'should be invalid without body' do
      expect(build(:comment,
                   body: nil,
                   user_id: comment.user_id,
                   image_id: comment.image_id)).not_to be_valid
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