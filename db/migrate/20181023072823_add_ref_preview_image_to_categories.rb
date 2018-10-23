class AddRefPreviewImageToCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :image
  end
end
