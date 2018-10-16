ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    panel "Categories" do
      table_for Category.order('created_at DESC').limit(5) do |category|
        category.column(:name)
        category.column(:count)
      end
    end

    panel "Comments" do
      table_for Comment.order('created_at DESC').limit(5) do |comment|
        comment.column(:body)
        comment.column(:user_id)
        comment.column(:image_id)
      end
    end

    panel "Images" do
      table_for Image.order('created_at DESC').limit(10) do |image|
        column :picture do |img|
          image_tag(img.picture.thumb_small.url, alt: 'Image')
        end
        column :user_id do |img|
          User.find(img.user_id).username
        end
        column :category_id do |img|
          Category.find(img.category_id).name
        end
      end
    end
  end # content
end