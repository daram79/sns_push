class CreateSmartPushWords < ActiveRecord::Migration
  def change
    create_table :smart_push_words do |t|
      t.integer :sns_content_id
      t.string :word
      t.timestamps null: false
    end
    add_index :smart_push_words, [:sns_content_id, :word], unique: true
    add_index :smart_push_words, :created_at
  end
end
