# frozen_string_literal: true

ActiveAdmin.register Feedback do
  permit_params :email_author, :name, :feedback
end
