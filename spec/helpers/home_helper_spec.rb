# frozen_string_literal: true

require 'rails_helper'

describe HomeHelper, type: :helper do
  context '#get_slider_img' do
    it 'should be set Dir(class) path to ../app/assets/images/slider' do
      helper.get_slider_img
      expect(Dir.pwd).to eq("#{Rails.root}/app/assets/images/slider")
    end

    it 'should be return array name images for slider' do
      expect(helper.get_slider_img.is_a?(Array)).to be_truthy
    end
  end
end
