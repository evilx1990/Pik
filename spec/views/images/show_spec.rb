#frozen_string_literal: true

require 'rails_helper'

describe 'images/show.html.haml', type: :view, driver: :selenium_chrome_headless do
  let(:category) { create(:category_with_img_cmnt_fllw) }

  before do
    login_as(create(:user), scope: :user)
    assign(:image, category.images.second)
    assign(:comments, category.images.second.comments)
    visit category_image_path(category_id: category.slug, id: category.images.second.slug)
  end

  it 'has a request.fullpath that is defined' do
    controller.extra_params = { category_id: category.slug, id: category.images.second.slug }
    expect(controller.request.fullpath).to eq(category_image_path(category_id: category.slug, id: category.images.second.slug))
  end

  context 'rendered partials' do
    it 'the comments/form template' do
      expect(page).to render_template('comments/_form')
    end

    it 'the comments/comment template' do
      expect(page).to render_template('comments/_comment')
    end

    it 'the comments/modal template' do
      expect(page).to render_template('images/_modal')
    end
  end

  it 'should be have image' do
    expect(page).to have_selector('#image > div.container.position-relative.pl-0.pr-0 > img')
  end

  context 'should be contain social links' do
    it 'download link' do
      expect(page).to have_selector('#image > div.d-flex.justify-content-center.text-white.mt-2 > a:nth-child(5)')
    end

    it 'share link' do
      expect(page).to have_selector('#image > div.d-flex.justify-content-center.text-white.mt-2 > a:nth-child(6)')
    end
  end

  context 'should be contain navigate links' do
    it 'next image link' do
      expect(page).to have_selector('#next')
    end

    it 'previous image link' do
      expect(page).to have_selector('#previous')
    end

    it 'back to category/show link' do
      expect(page).to have_selector('#back')
    end
  end

  context 'should be contain like/dislike links' do
    it 'like link' do
      expect(page).to have_selector('#like')
    end

    it 'dislike link' do
      expect(page).to have_selector('#dislike')
    end

    context 'click on like/dislike links' do
      it 'should be increment like counter' do
        find('#like').click
        sleep(1.5)
        expect(find('#likes-count').text).to eq '1'
      end

      it 'should be decrement like counter' do
        2.times { find('#like').click }
        sleep(1.5)
        expect(find('#likes-count').text).to eq '0'
      end

      it 'should be increment dislike counter' do
        find('#dislike').click
        sleep(1.5)
        expect(find('#dislikes-count').text).to eq '1'
      end

      it 'should be decrement dislike counter' do
        2.times { find('#dislike').click }
        sleep(1.5)
        expect(find('#dislikes-count').text).to eq'0'
      end
    end
  end

  context 'should be contain create comment form' do
    it 'comment body field' do
      expect(page).to have_field('comment_body')
    end

    it 'create comment button' do
      expect(page).to have_button('Create comment')
    end
  end

  context 'should be contain users comment' do
    it 'user avatar' do
      expect(page).to have_selector('#black-bg > div.container > div:nth-child(2) > div > img')
    end

    it 'username' do
      expect(page).to have_selector('#black-bg > div.container > div:nth-child(2) > div > div.uname')
    end

    it 'comment body' do
      expect(page).to have_selector('#black-bg > div.container > div:nth-child(2) > div > div.comment-body')
    end
  end

  context 'modal window' do
    context 'should be contain' do
      before do
        find('#image > div.d-flex.justify-content-center.text-white.mt-2 > a:nth-child(6)').click
      end

      it 'header text <Share>' do
        expect(page).to have_text('Share')
      end

      it 'button <X>' do
        expect(page).to have_button('x')
      end

      it 'email field' do
        expect(page).to have_field('share_email')
      end

      it 'message field' do
        expect(page).to have_field('share_message')
      end

      it '<share> button' do
        expect(page).to have_button('share')
      end
    end
  end
end
