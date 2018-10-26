class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string      :picture, null: false
      t.references  :user
      t.references  :category, foreign_key: true

      t.timestamps
    end
  end
end
