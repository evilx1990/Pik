class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string      :picture, null: false
      t.integer     :comments_count, default: 0
      t.integer     :votes_count, default: 0
      t.references  :user
      t.references  :category, foreign_key: true

      t.timestamps
    end
  end
end
