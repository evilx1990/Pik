# frozen_string_literal: true

require 'rails_helper'

describe AdminUser, type: :model do
  subject(:admin_user) { create(:admin_user) }

  it 'should be invalid without an email' do
    expect(build(:admin_user,
                 email: nil,
                 password: admin_user.password)).not_to be_valid
  end

  it 'should be invalid without an password' do
    expect(build(:admin_user,
                 email: admin_user.email,
                 password: nil)).not_to be_valid
  end
end
