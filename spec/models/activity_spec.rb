# frozen_string_literal: true

require 'rails_helper'

describe Activity, type: :model do
  subject(:activity) { create(:activity) }

  context 'associations' do
    it 'belongs to user' do
      respond_to? :user
    end
  end

  context 'validates' do
    it 'should be invalid without action' do
      expect(build(:activity, action: nil, url: activity.url)).not_to be_valid
    end

    it 'should be invalid without url' do
      expect(build(:activity, action: activity.action, url: nil)).not_to be_valid
    end
  end
end