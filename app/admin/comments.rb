ActiveAdmin.register Comment do
  permit_params :body, :image_id, :user_id
end
