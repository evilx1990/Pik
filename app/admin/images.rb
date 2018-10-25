ActiveAdmin.register Image do
  menu priority: 5
  permit_params :picture, :user_id, :category_id

end
