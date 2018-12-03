# frozen_string_literal: true

require 'rails_helper'

describe 'categories/index.html.haml', type: :view do
  let(:categories) { create_list(:category, 2) }

  before do
    @user = create(:user)
    sign_in(@user)
    assign(:category, build(:category))
    assign(:categories, categories)
    render
  end

  it 'has a request.fullpath that is defined' do
    expect(controller.request.fullpath).to eq(categories_path)
  end

  it 'should be render list categories' do
    expect(rendered).to match(/#{categories.first.name}/)
    expect(rendered).to match(/#{categories.last.name}/)
  end

  context 'should be have link ' do
    let(:user) { create(:user) }
    let(:cateoory) { create(:category, user: user) }

    it 'with category/show acton' do
      expect(rendered).to have_link(alt: 'Image')
    end

    it 'link with category/follow acton' do
      expect(rendered).to have_link(alt: 'follow')
    end

    it 'link with category/unfollow action' do
      assign(:category, build(:category))
      assign(:categories, [create(:category_with_follow, user: @user)])
      render
      expect(rendered).to have_link(alt: 'unfollow')
    end
  end

  it 'should be render _modal.html.haml' do
    expect(rendered).to render_template(partial: '_modal')
  end
end
