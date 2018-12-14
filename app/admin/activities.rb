ActiveAdmin.register Activity do
  config.clear_action_items!

  filter :user
  filter :action
  filter :created_at

  index do
    id_column
    column :user
    column :action
    column :url
    column :created_at
  end
end
