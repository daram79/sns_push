class CreateUserPushKeys < ActiveRecord::Migration
  def change
    create_table :user_push_keys do |t|
      t.integer :user_id
      t.integer :sns_push_key_id
      t.timestamps null: false
    end
    add_index :user_push_keys, :sns_push_key_id
  end
end
