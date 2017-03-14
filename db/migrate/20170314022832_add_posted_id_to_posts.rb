class AddPostedIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :posted_id, :integer
  end
end
