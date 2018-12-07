ActiveAdmin.register Category do
  menu priority: 4
  permit_params :name, :user_id

  controller do
    def find_resource
      @category = Category.friendly.find(params[:id])
    end
  end

  form do |f|
    f.inputs 'Category details' do
      f.input :name
      f.input :user_id, as: :select, collection: User.all, include_blank: false
    end
    f.actions
  end
end
