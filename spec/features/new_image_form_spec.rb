# frozen_string_literal: true

require 'rails_helper'

describe 'Upload image form', type: :view do
  let(:category) { create(:category_with_images) }

  it 'should be print new image form', driver: :selenium_chrome_headless do
    login_as(create(:user), scope: :user)
    visit category_path(category)
    click_link('Upload image')
    expect(page).to have_field('image_picture')
    expect(page).to have_field('image_image_name')
    expect(page).to have_button('Upload image')
  end
end