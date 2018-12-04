class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows, force: true do |t|
      t.references :category
      t.references :user

      t.timestamps
    end

    add_index :follows, :category_id, name: 'fk_categories'
    add_index :follows, :user_id, name: 'fk_users'
  end
end