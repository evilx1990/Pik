class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string      :path, null: false
      t.float       :size, null: false
      t.references  :users, foreign_key: true
      t.references  :categories, foreign_key: true

      t.timestamps
    end
  end
end
