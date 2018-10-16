ActiveAdmin.register Activity do
  permit_params :user_id, :action, :url
end
