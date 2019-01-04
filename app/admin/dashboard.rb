# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Last images' do
          table_for Image.order(created_at: :desc).limit(10) do
            column :image do |image|
              image_tag image.picture.thumb_small.url, alt: 'Image'
            end
            column :user
            column :category
          end
        end
      end

      column do
        panel 'Last categories' do
          table_for Category.order(created_at: :desc).limit(5) do
            column :name do |category|
              link_to category.name, admin_category_path(category)
            end
            column(:user)
            column(:created_at)
          end
        end

        panel 'Last comments' do
          table_for Comment.order(created_at: :desc).limit(5) do
            column :comment do |comment|
              link_to 'Show comment', admin_comment_path(comment)
            end
            column :user
            column :image do |comment|
              image_tag comment.image.picture.thumb_small.url, alt: 'img'
            end
          end
        end
      end
    end

    columns do
      column do
        panel 'Unread feedbaks' do
          table_for Feedback.where(state: false).order(created_at: :asc).limit(10) do
            column :email_author
            column :name
            column :feedback
            column '>>' do |feedback|
              link_to('reply', admin_feedback_reply_feedback_path(feedback))
            end
          end
        end
      end
    end
  end
end
