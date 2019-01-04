class AddNameToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :name, :string
  end
end
