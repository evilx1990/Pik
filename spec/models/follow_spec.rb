# frozen_string_literal: true

require 'rails_helper'

describe Follow, type: :model do
  context 'association' do
    it 'belongs to category' do
      respond_to :category
    end

    it 'belongs_to user' do
      respond_to :user
    end
  end
end