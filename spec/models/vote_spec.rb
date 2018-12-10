# frozen_string_literal: true

require 'rails_helper'

describe Vote, type: :model do
  context 'Association' do
    it 'belongs to user' do
      expect(Vote.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to image' do
      expect(Vote.reflect_on_association(:image).macro).to eq(:belongs_to)
    end
  end
end