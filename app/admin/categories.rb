ActiveAdmin.register Category do
  menu priority: 4
  permit_params :name, :user_id
end
