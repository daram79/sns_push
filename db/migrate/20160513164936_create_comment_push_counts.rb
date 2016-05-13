class CreateCommentPushCounts < ActiveRecord::Migration
  def change
    create_table :comment_push_counts do |t|
      t.integer :user_id
      t.integer :sns_id
      t.integer :count
      t.timestamps null: false
    end
    add_index :comment_push_counts, [:sns_id, :count]
    add_index :comment_push_counts, [:user_id, :sns_id]
  end
end
