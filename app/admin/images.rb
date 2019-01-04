# frozen_string_literal: true

ActiveAdmin.register Image do
  menu priority: 5
  permit_params :image_name, :picture, :category_id

  filter :name
  filter :user
  filter :created_at
  filter :updated_at

  controller do
    def find_resource
      @image = Image.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :image do |image|
      image_tag(image.picture.thumb_small.url, alt: 'image')
    end
    column :author, &:user
    column :category
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel 'image Details' do
      attributes_table_for image do
        row :image do
          link_to(image_tag(image.picture.thumb_list.url, alt: 'image', style: 'width: 50%'),
                  image.picture.url, target: '_blank')
        end
        row :name do
          image.image_name
        end
        row :author do
          image.user
        end
        row :category do
          image.category
        end
        row :created_at
      end
    end
  end

  form do |f|
    f.inputs 'Image details' do
      f.input :image_name
      f.input :category, as: :select, collection: Category.all, include_blank: false
    end
    f.actions
  end
end
