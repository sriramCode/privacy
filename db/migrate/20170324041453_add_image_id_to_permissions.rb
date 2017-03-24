class AddImageIdToPermissions < ActiveRecord::Migration[5.0]
  def change
    add_column :permissions, :image_id, :integer
  end
end
