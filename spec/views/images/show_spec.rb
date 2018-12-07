#frozen_string_literal: true

require 'rails_helper'

describe 'images/show.html.haml', type: :view do
  let(:image) { create(:image_with_comments) }

  before do
    login_as(create(:user), scope: :user)
    assign(:image, image)
    assign(:comments, image.comments)
    visit category_image_path(category_id: image.category.id, id: image.id)
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
    expect(page).to have_xpath('//*[@id="show-image"]/img')
  end

  context 'should be contain social links' do
    it 'download link' do
      expect(page).to have_selector('#social > a.d-block.float-right.mr-1 > img')
    end

    it 'share link' do
      expect(page).to have_selector('#social > a.d-block.float-right.mr-5 > img')
    end
  end

  context 'should be contain like/dislike links' do
    it 'like link' do
      expect(page).to have_selector('#likes > a:nth-child(1) > img')
    end

    it 'dislike link' do
      expect(page).to have_selector('#likes > a:nth-child(4) > img')
    end

    context 'click on like/dislike links', driver: :selenium_chrome_headless do
      it 'should be increment like counter' do
        find('#likes > a:nth-child(1) > img').click
        sleep(1)
        expect(find('#like-counter').text).to eq '1'
      end

      it 'should be decrement like counter' do
        2.times { find('#likes > a:nth-child(1) > img').click }
        sleep(1)
        expect(find('#like-counter').text).to eq '0'
      end

      it 'should be increment dislike counter' do
        find('#likes > a:nth-child(4) > img').click
        sleep(1)
        expect(find('#dislike-counter').text).to eq '1'
      end

      it 'should be decrement dislike counter' do
        2.times { find('#likes > a:nth-child(4) > img').click }
        sleep(1)
        expect(find('#dislike-counter').text).to eq'0'
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
      expect(page).to have_selector('#comment > img')
    end

    it 'username' do
      expect(page).to have_selector('#uname')
    end

    it 'publication date' do
      expect(page).to have_selector('#date')
    end

    it 'comment body' do
      expect(page).to have_selector('#body')
    end
  end

  context 'modal window' do
    context 'should be contain' do
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

      it '<Close> button' do
        expect(page).to have_button('Close')
      end
    end
  end
end
