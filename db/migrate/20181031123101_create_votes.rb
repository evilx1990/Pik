class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :image, index: true
      t.references :user, index: true
      t.boolean :flag

      t.timestamps
    end
  end
end