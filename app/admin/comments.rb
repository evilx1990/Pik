ActiveAdmin.register Comment do
  permit_params :body

  filter :user
  filter :image
  filter :created_at
  filter :updates_at

  index do
    selectable_column
    id_column
    column :comment do |comment|
      comment.body.truncate(20)
    end
    column :image do |comment|
      image_tag(comment.image.picture.thumb_small.url, alt: 'image')
    end
    column :user
    column :created_at
    actions
  end

  show do
    panel 'comment Details' do
      attributes_table_for comment do
        row :comment, &:body
        row :author, &:user
        row :image do |comment|
          image_tag(comment.image.picture.thumb_small.url, alt: 'image')
        end
        row :created_at
        row :updated_at
      end
    end
  end

  form do |f|
    f.inputs 'Comment Details' do
      f.input :body
      f.input :user_id, as: :select, collection: User.all, include_blank: false
    end
    f.actions
  end
end
