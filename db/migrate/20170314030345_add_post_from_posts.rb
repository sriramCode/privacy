class AddPostFromPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :post, :string
  end
end
