ActiveAdmin.register Comment do
  permit_params :body, :image_id, :user_id

  form do |f|
    f.inputs 'Comment Details' do
      f.input :body
      f.input :user_id, as: :select, collection: User.all, include_blank: false
    end
    f.actions
  end
end
