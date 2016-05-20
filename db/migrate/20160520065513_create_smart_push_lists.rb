class CreateSmartPushLists < ActiveRecord::Migration
  def change
    create_table :smart_push_lists do |t|
      t.integer :sns_content_id
      t.boolean :is_show, default: true
      t.timestamps null: false
    end
    add_index :smart_push_lists, :is_show
  end
end
