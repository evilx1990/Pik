class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string      :name, null: false # Имя категории
      t.integer     :count, default: 0 # Количество картинок в категории
      t.references  :user, foreign_key: true

      t.timestamps
    end
  end
end
