ActiveAdmin.register Category do
  menu priority: 4
  permit_params :name, :user_id

  form do |f|
    f.inputs 'Category details' do
      f.input :name
      f.input :user_id, as: :select, collection: User.all, include_blank: false
    end
    f.actions
  end
end
