class RemovePictureFromImage < ActiveRecord::Migration[5.0]
  def change
    remove_column :images, :picture, :string
  end
end
