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

  context 'links' do
    let(:cateoory) { create(:category, user: @user) }

    it 'with categories/show action' do
      expect(rendered).to have_link(alt: 'Image')
    end

    it 'link with categories/follow action' do
      expect(rendered).to have_link(alt: 'follow')
    end

    it 'link with categories/unfollow action' do
      assign(:category, build(:category))
      assign(:categories, [create(:category_with_follow, user: @user)])
      render
      expect(rendered).to have_link(alt: 'unfollow')
    end
  end

  context 'modal window' do
    it 'should be rendered' do
      expect(rendered).to render_template(partial: 'categories/_modal')
    end

    it 'should be contain categories/form' do
      expect(rendered).to render_template(partial: 'categories/_form')
    end

    it 'should be have text <Add category>' do
      expect(rendered).to have_text('Add category')
    end

    it 'should be have field <Name>' do
      expect(rendered).to have_field('category_name')
    end

    it 'should be have button <Add category>' do
      expect(rendered).to have_button('Add category')
    end

    it 'should be have small text <minimum 3 symbols> under <Name> field' do
      expect(rendered).to have_selector('small')
      expect(rendered).to have_text('minimum 3 symbols')
    end

    it 'should be have button <Close>' do
      expect(rendered).to have_button('Close')
    end

    it 'should be have button <X>' do
      expect(rendered).to have_button('x')
    end
  end
end
