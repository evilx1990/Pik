# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  subject(:user) { create(:user) }

  context 'validation' do
    it 'should be invalid without an username' do
      expect(build(:user,
                   email: user.email,
                   password: nil,
                   username: user.username)).not_to be_valid
    end

    it 'does not allow duplicate username' do
      expect(build(:user,
                   email: user.email,
                   password: user.password,
                   username: user.username)).not_to be_valid
    end
  end

  context 'association' do
    it 'has many activity' do
      respond_to :activities
    end

    it 'has many follows(polymorphic)' do
      respond_to :follower
    end

    it 'has many categories' do
      respond_to :categories
    end

    it 'has many images' do
      respond_to :images
    end

    it 'has many comments' do
      respond_to :comments
    end

    it 'has many votes' do
      respond_to :votes
    end
  end
end