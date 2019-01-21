# frozen_string_literal: true

require 'rails_helper'

describe 'layouts/application.html.haml', type: :view, driver: :selenium_chrome_headless do
  context 'before user login' do
    before do
      visit root_path
    end

    it 'should be render' do
      expect(page).to render_template(layout: :application)
    end

    context 'should be contain' do
      it 'link <Log in>' do
        expect(page).to have_link('Log in')
      end

      it 'link <Sign up>' do
        expect(page).to have_link('Sign up')
      end

      it 'link <Ru>' do
        expect(page).to have_link('Ru')
      end

      it 'link <En>' do
        click_link('Ru')
        expect(page).to have_link('En')
      end
    end
  end

  context 'after user login' do
    before do
      @user = create(:user)
      login_as(@user, scope: :user)
      visit categories_path
    end

    it 'should be render' do
      expect(page).to render_template(layout: :application)
    end

    context 'should be contain' do
      context 'link <Top categories> dropdown menu' do
        it 'dropdown menu link' do
          expect(page).to have_link('Top categories')
        end

        context 'empty menu' do
          it 'should be have cell <Empty>' do
            find_link(text: 'Top categories').click
            expect(page).to have_selector('.dropdown-item', text: 'Empty')
          end
        end

        context 'menu with items' do
          let(:categories) { create_list(:category, 5) }

          before do
            categories
            visit categories_path
          end

          it 'should be have items' do
            find_link(text: 'Top categories').click

            categories.each do |category|
              expect(page).to have_selector('.dropdown-item', text: category.name)
            end
          end
        end
      end

      it 'link <Categories>' do
        expect(page).to have_link('Categories')
      end

      it 'link <Images>' do
        expect(page).to have_link('Images')
      end

      it 'link <Comments>' do
        expect(page).to have_link('Comments')
      end

      it 'link <Ru>' do
        expect(page).to have_link('Ru')
      end

      it 'link <En>' do
        click_link('Ru')
        expect(page).to have_link('En')
      end

      context 'link <Username> dropdown menu' do
        it 'dropdown menu link' do
          expect(page).to have_link(@user.username)
        end

        context 'should be have items' do
          let (:category) { create(:category_with_images) }

          it 'for /categories' do
            find_link(@user.username).click

            ['Create category', 'Profile', 'Log out'].each do |item|
              expect(page).to have_selector('.dropdown-item', text: item)
            end
          end

          it 'for /categories/CategoryName' do
            category
            visit category_path(category)

            find_link(@user.username).click

            ['Edit category', 'Profile', 'Log out'].each do |item|
              expect(page).to have_selector('.dropdown-item', text: item)
            end
          end
        end
      end
    end
  end
end