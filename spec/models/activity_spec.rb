# frozen_string_literal: true

require 'rails_helper'

describe Activity, type: :model do
  context 'save record in db' do
    it { expect(create(:activity).save).to be true }
  end
end