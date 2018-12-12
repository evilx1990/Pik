# frozen_string_literal: true

require 'rails_helper'

describe Activity, type: :model do
  context 'associations' do
    it 'belongs to user' do
      expect(Activity.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  context 'validates' do
    subject!(:activity) { create(:activity) }

    context 'should be invalid' do
      it 'without an  action' do
        expect(build(:activity, action: nil, url: activity.url)).not_to be_valid
      end

      it 'without url' do
        expect(build(:activity, action: activity.action, url: nil)).not_to be_valid
      end
    end

    context 'successful validate' do
      it 'must be save to data base' do
        expect(Activity.count).to eq(1)
      end
    end
  end
end
