class AddSlugToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :slug, :string
    add_index :images, :slug, unique: true
  end
end
