# frozen_string_literal: true

require 'rails_helper'

describe 'images/index.html.haml', type: :view do
  let(:images) { create_list(:image, 5)}

  before do
    sign_in(create(:user))
    images
    assign(:images, Image.order(votes_count: :desc).page(params[:page]).per(20))
    render
  end

  it 'should be render list images' do
    expect(rendered).to have_selector('img')
  end

  context 'links' do
    it 'with images/show action' do
      expect(rendered).to have_link(alt: 'picture')
    end
  end
end