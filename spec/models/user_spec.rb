# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do

  context 'validation' do
    subject!(:user) { create(:user) }

    context 'should be invalid ' do
      it 'without an username' do
        expect(build(:user,
                     email: user.email,
                     password: nil,
                     username: user.username)).not_to be_valid
      end

      it 'with duplicate username' do
        expect(build(:user,
                     email: user.email,
                     password: user.password,
                     username: user.username)).not_to be_valid
      end
    end

    context 'successful validation' do
      it 'must be save to data base' do
        expect(User.count).to eq(1)
      end
    end
  end

  context 'association' do
    it 'has many activities' do
      expect(User.reflect_on_association(:activities).macro).to eq(:has_many)
    end

    it 'has many follows' do
      expect(User.reflect_on_association(:follows).macro).to eq(:has_many)
    end

    it 'has many categories' do
      expect(User.reflect_on_association(:categories).macro).to eq(:has_many)
    end

    it 'has many images' do
      expect(User.reflect_on_association(:images).macro).to eq(:has_many)
    end

    it 'has many comments' do
      expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'has many votes' do
      expect(User.reflect_on_association(:votes).macro).to eq(:has_many)
    end

  end

  describe '#logins_before_captcha' do
    it 'should be return 2' do
      expect(User.logins_before_captcha).to eq(2)
    end
  end

  describe 'dependent: destroy' do
    let(:user_category) { create(:category).user }
    let(:user_activity) { create(:activity).user }

    it 'should be destroy all related category' do
      user_category.destroy
      expect(Category.count).to eq(0)
    end

    it 'should be destroy all related activity' do
      user_activity.destroy
      expect(Activity.count).to eq(0)
    end
  end
end