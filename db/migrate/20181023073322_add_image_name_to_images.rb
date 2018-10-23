class AddImageNameToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :image_name, :string
  end
end
