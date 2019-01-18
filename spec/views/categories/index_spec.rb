# frozen_string_literal: true

require 'rails_helper'

describe 'categories/index.html.haml', type: :view, driver: :selenium_chrome_headless do
  let(:category) { create(:category) }

  before do
    @user = create(:user)
    login_as(@user, scope: :user)
    assign(:category, build(:category))
    assign(:categories, [category])
    visit categories_path
  end

  it 'has a request.fullpath that is defined' do
    expect(controller.request.fullpath).to eq(categories_path)
  end

  it 'should be render list categories' do
    expect(page).to have_text(category.name.upcase)
  end

  context 'links' do
    let(:cateoory) { create(:category, user: @user) }

    it 'with categories/show action' do
      expect(page).to have_link('show category')
    end

    it 'link with categories/follow action' do
      expect(page).to have_link('follow')
    end

    it 'link with categories/unfollow action' do
      find('#category_0 > a').click
      sleep(1.5)
      expect(page).to have_link('unfollow')
    end
  end

  context 'modal window' do
    before do
      find('#menu > ul > li:nth-child(5) > a').click
      find('#menu > ul > li.nav-item.dropdown.active.show > div > a:nth-child(1)').click
    end

    it 'should be rendered' do
      expect(page).to render_template(partial: 'categories/_modal')
    end

    it 'should be contain categories/form' do
      expect(page).to render_template(partial: 'categories/_form')
    end

    it 'should be have text <Create category>' do
      expect(page).to have_text('Create category')
    end

    it 'should be have field <Name>' do
      expect(page).to have_field('category_name')
    end

    it 'should be have button <Create category>' do
      expect(page).to have_button('Create category')
    end

    it 'should be have small text <preview album> under <Name> field' do
      expect(page).to have_selector('small')
      expect(page).to have_text('preview album')
    end

    it 'should be have button <X>' do
      expect(page).to have_button('x')
    end
  end
end
