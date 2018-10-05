class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false # Имя категории
      t.integer :count, default: 0 # Количество картинок в категории
      t.string :username, null: false, default: "auto generate" # Имя пользователя создавшего категорию

      t.timestamps
    end
  end
end
