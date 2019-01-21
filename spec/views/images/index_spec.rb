# frozen_string_literal: true

require 'rails_helper'

describe 'images/index.html.haml', type: :view, driver: :selenium_chrome do
  let(:images) { create_list(:image, 5)}

  before do
    login_as(create(:user), scope: :user)
    images
    assign(:images, Image.order(votes_count: :desc).page(params[:page]).per(20))
    visit images_path
  end

  it 'has a request.fullpath that is defined' do
    expect(controller.request.fullpath).to eq(images_path)
  end

  it 'should be render list images' do
    expect(page).to have_selector('#index-images-list > div > div > div:nth-child(1) > div > img')
  end
end
