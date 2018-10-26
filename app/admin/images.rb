ActiveAdmin.register Image do
  menu priority: 5
  permit_params :image_name, :picture, :category_id, :user_id

  form do |f|
    f.inputs 'Image details' do
      f.input :picture
      f.input :image_name
      f.input :user_id,     as: :select, collection: User.all, include_blank: false
      f.input :category_id, as: :select, collection: Category.all, include_blank: false
    end
    f.actions
  end

end
