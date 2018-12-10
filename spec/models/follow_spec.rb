# frozen_string_literal: true

require 'rails_helper'

describe Follow, type: :model do
  context 'association' do
    it 'belongs to category' do
      expect(Follow.reflect_on_association(:category).macro).to eq(:belongs_to)
    end

    it 'belongs_to user' do
      expect(Follow.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end