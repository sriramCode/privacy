class CreatePost < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
    	t.integer "post"
    	t.integer "user_id"
    end
  end
end
