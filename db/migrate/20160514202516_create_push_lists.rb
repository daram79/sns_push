class CreatePushLists < ActiveRecord::Migration
  def change
    create_table :push_lists do |t|
      t.boolean :is_push, default: true
      t.boolean :is_recommend, default: false
      t.boolean :is_error, default: false
      t.timestamps null: false
    end
    add_index :push_lists, :is_push
  end
end
