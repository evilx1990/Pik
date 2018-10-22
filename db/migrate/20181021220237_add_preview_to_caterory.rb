class AddPreviewToCaterory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :preview, :string
  end
end
