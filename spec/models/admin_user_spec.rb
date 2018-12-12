# frozen_string_literal: true

require 'rails_helper'

describe AdminUser, type: :model do
  context 'validates' do
    subject!(:admin_user) { create(:admin_user) }

    context 'should be invalid' do
      it 'without an email' do
        expect(build(:admin_user,
                     email: nil,
                     password: admin_user.password)).not_to be_valid
      end

      it 'without an password' do
        expect(build(:admin_user,
                     email: admin_user.email,
                     password: nil)).not_to be_valid
      end
    end

    context 'successful validate' do
      it 'must be save to data base' do
        expect(AdminUser.count).to eq(1)
      end
    end
  end
end
