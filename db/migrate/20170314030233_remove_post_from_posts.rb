class RemovePostFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :post, :integer
  end
end
