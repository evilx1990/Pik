ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    panel "Statistics" do
      table_for Category.order("created_at DESC").limit(5) do |category|
        category.column(:name)
        category.column(:count)
      end

      table_for Comment.order("created_at DESC").limit(5) do |comment|
        comment.column(:body)
        comment.column(:user_id)
        comment.column(:image_id)
      end

      table_for Image.order("created_at DESC").limit(10) do |image|
        image.column(:path)
        image.column(:user_id)
        image.column(:category_id)
      end

    end # panel
  end # content
end
