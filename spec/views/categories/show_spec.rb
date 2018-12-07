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
    it 'with images/show action' do
      expect(rendered).to have_link(alt: 'picture')
    end

    it 'with images/new action' do
      expect(rendered).to have_link('Upload image')
    end
  end

  context 'upload image form', driver: :selenium_chrome_headless do
    let(:category) { create(:category_with_images) }

    it 'should be print new image form' do
      login_as(create(:user), scope: :user)
      visit category_path(category)
      click_link('Upload image')
      expect(page).to have_field('image_picture')
      expect(page).to have_field('image_image_name')
      expect(page).to have_button('Upload image')
    end
  end

  context 'modal window' do
    let(:category_current_user) { create(:category, user: @user)}

    it 'should be rendered' do
      expect(rendered).to render_template(partial: 'categories/_modal')
    end

    it 'should be contain categories/form' do
      expect(rendered).to render_template(partial: 'categories/_form')
    end

    it 'should be have text <Edit category>' do
      expect(rendered).to have_text('Edit category')
    end

    it 'should be have field <Name>' do
      expect(rendered).to have_field('category_name')
    end

    it 'should be have selector <select>' do
      expect(rendered).to have_selector('select')
    end

    it 'should be have button <Edit category>' do
      expect(rendered).to have_button('Edit category')
    end

    it 'should be have small text <minimum 3 symbols> under <Name> field' do
      expect(rendered).to have_selector('small')
      expect(rendered).to have_text('minimum 3 symbols')
    end

    it 'should be have delete link if owner not current user' do
      expect(rendered).not_to have_link('Delete category')
    end

    it 'should be have delete link if owner is current user' do
      assign(:category, category_current_user)
      assign(:images, category_current_user.images.order(id: :asc).page(params[:page]))
      render
      expect(rendered).to have_link('Delete category')
    end

    it 'should be have button <Close>' do
      expect(rendered).to have_button('Close')
    end

    it 'should be have button <X>' do
      expect(rendered).to have_button('x')
    end
  end
end