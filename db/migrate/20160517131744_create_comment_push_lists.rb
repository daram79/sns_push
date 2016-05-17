class CreateCommentPushLists < ActiveRecord::Migration
  def change
    create_table :comment_push_lists do |t|
      t.boolean :is_push, default: true
      t.integer :user_id
      t.integer :sns_content_id
      t.timestamps null: false
    end
    add_index :comment_push_lists, :is_push
    add_index :comment_push_lists, :user_id
  end
end
