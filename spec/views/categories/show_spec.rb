# frozen_string_literal: true

require 'rails_helper'

describe 'categories/show.html.haml', type: :view, driver: :selenium_chrome do
  let(:category) { create(:category_with_images) }

  before do
    @user = create(:user)
    login_as(@user, scope: :user)
    assign(:category, category)
    assign(:images, category.images.order(id: :asc).page(params[:page]))
    visit category_path(category)
  end

  it 'has a request.fullpath that is defined' do
    controller.extra_params = { id: category.slug }
    expect(controller.request.fullpath).to eq(category_path(category))
  end

  it 'should be render list images' do
    expect(page).to have_selector('img')
  end

  context 'links' do
    it 'with images/show action' do
      expect(page).to have_link(alt: 'picture')
    end

    it 'with images/new action' do
      expect(page).to have_link('Upload image')
    end
  end

  context 'modal window', driver: :selenium_chrome do
    let(:category_current_user) { create(:category, user: @user)}

    before do
      login_as(@user, scope: :user)
      visit category_path(category_current_user)

      find('#menu > ul > li:nth-child(5) > a').click
      find('#menu > ul > li.nav-item.dropdown.active.show > div > a:nth-child(1)').click
    end

    it 'should be rendered' do
      expect(page).to render_template(partial: 'categories/_modal')
    end

    it 'should be contain categories/form' do
      expect(page).to render_template(partial: 'categories/_form')
    end

    it 'should be have text <Edit category>' do
      expect(page).to have_text('Edit category')
    end

    it 'should be have field <Name>' do
      expect(page).to have_field('category_name')
    end

    it 'should be have button <Edit category>' do
      expect(page).to have_button('Edit category')
    end

    it 'should be have small text <preview album>' do
      expect(page).to have_selector('small')
      expect(page).to have_text('preview album')
    end

    it 'should be have button <X>' do
      expect(page).to have_button('x')
    end

    context "don't render the category/form template" do
      it 'if owner not current user' do
        visit category_path(category)
        expect(page).not_to render_template(partial: 'category/_form')
      end
    end
  end
end