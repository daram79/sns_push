class CreateUserPushContents < ActiveRecord::Migration
  def change
    create_table :user_push_contents do |t|
      t.integer :user_id
      t.integer :sns_content_id
      t.boolean :is_push, default: false
      t.timestamps null: false
    end
    add_index :user_push_contents, :is_push
    add_index :user_push_contents, [:user_id, :sns_content_id], :unique => true
  end
end
