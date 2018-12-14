ActiveAdmin.register Category do
  menu priority: 4
  permit_params :name, :image_id

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
    column :image do |category|
      image_tag(category.image.picture.thumb_small.url, alt: 'image') if category.image.present?
    end
    actions
  end

  show do
    panel 'Category Details' do
      attributes_table_for category do
        row :author, &:user
        row :name
        row 'preview image  ' do |category|
          image_tag(category.image.picture.thumb_small.url, alt: 'image') if category.image
        end
      end
    end
  end

  form  do |f|
    f.inputs 'Category details' do
      f.input :name, input_html: { style: 'width: 100px' }
      f.input :image, as: :select, collection: Hash[category.images.map { |i| [i.image_name, i.id] } ], include_blank: true
    end
    f.actions
  end
end
