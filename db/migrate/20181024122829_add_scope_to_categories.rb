class AddScopeToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :scope, :integer, default: 0
  end
end
