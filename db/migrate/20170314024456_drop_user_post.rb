class DropUserPost < ActiveRecord::Migration[5.0]
  def change
  	create_table "posts_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "post_id"
  end
  end
end
