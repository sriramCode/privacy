class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
    	t.integer "user_id"
    	t.integer "post_id"
    	t.string "status"

    t.timestamps
    end
  end
end
