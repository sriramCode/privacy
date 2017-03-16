class AddImageableTypeToImage < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :imageable_type, :string
    add_column :images, :imageable_id, :integer
  end
end
