class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string      :name, null: false # Имя категории
      t.integer     :images_count, default: 0 # Количество картинок в категории
      t.integer     :follows_count, default: 0 # Количество подпищиков на категорию
      t.integer     :range_count, default: 0 # Топ
      t.references  :user

      t.timestamps
    end
  end
end
