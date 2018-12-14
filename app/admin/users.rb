ActiveAdmin.register User do
  menu priority: 3
  permit_params :email, :username, :avatar

  filter :username
  filter :email
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :avatar do |user|
      image_tag(user.avatar.thumb_small.url, alt: 'Image') if user.avatar.present?
    end
    column :username
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    panel 'user Detail' do
      attributes_table_for user do
        row :avatar do |user|
          image_tag(user.avatar.thumb_small.url, alt: 'avatar') if user.avatar.present?
        end
        row :username
        row :email
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :created_at
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email, input_html: { style: 'width: 20%' }
      f.input :username, input_html: { style: 'width: 20%' }
      f.input :avatar, input_html: { style: 'width: 20%' }
    end
    f.actions
  end
end
