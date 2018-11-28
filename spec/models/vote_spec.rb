# frozen_string_literal: true

require 'rails_helper'

describe Vote, type: :model do
  context 'Association' do
    it 'belongs to user' do
      respond_to :user
    end

    it 'belongs to image' do
      respond_to :image
    end
  end
end