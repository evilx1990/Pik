# frozen_string_literal: true

require 'rails_helper'

describe 'categories/show.html.haml', type: :view do
  let(:category) { create(:category_with_images) }

  before do
    @user = create(:user)
    sign_in(@user)
    assign(:category, category)
    assign(:images, category.images.order(id: :asc).page(params[:page]))
    render
  end

  it 'has a request.fullpath that is defined' do
    controller.extra_params = { id: category.slug }
    expect(controller.request.fullpath).to eq(category_path(category))
  end

  it 'should be render list images' do
    expect(rendered).to have_selector('img')
  end

  context 'links' do

  end
end