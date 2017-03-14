class NewImage < ActiveRecord::Migration[5.0]
  def change
  	create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
 
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  end
end
