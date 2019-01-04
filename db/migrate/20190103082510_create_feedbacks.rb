class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string  :email_author
      t.string  :feedback
      t.boolean :state, default: false

      t.timestamps
    end
  end
end
