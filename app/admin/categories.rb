# frozen_string_literal: true

ActiveAdmin.register Category do
  menu priority: 4
  permit_params :name

  filter :name
  filter :user
  filter :created_at
  filter :updated_at

  controller do
    def find_resource
      @category = Category.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :created_at
    column :updated_at
    column :preview do |category|
      image_tag(category.preview.thumb_small.url, alt: 'image') if category.preview.present?
    end
    actions
  end

  show do
    panel 'Category Details' do
      attributes_table_for category do
        row :author, &:user
        row :name
        row :preview do |category|
          image_tag(category.preview.thumb_small.url, alt: 'image') if category.preview.present?
        end
        row :followers do
          category.follows.each do |follow|
            a follow.user.username, href: admin_user_path(follow.user)
            text_node '&nbsp;'.html_safe
          end
        end
      end
    end
  end

  form  do |f|
    f.inputs 'Category details' do
      f.input :name, input_html: { style: 'width: 100px' }
    end
    f.actions
  end
end
