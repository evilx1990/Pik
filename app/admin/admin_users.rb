# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  menu priority: 2
  permit_params :email, :password, :password_confirmation

  filter :email

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    panel 'administrator Details' do
      attributes_table_for admin_user do
        row :email
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :created_at
        row :updated_a
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email, input_html: { style: 'width: 20%' }
      f.input :password, input_html: { style: 'width: 20%' }
      f.input :password_confirmation, input_html: { style: 'width: 20%' }
    end
    f.actions
  end
end
