class CreatePpomppuFreeboardWords < ActiveRecord::Migration
  def change
    create_table :ppomppu_freeboard_words do |t|
      t.integer :sns_content_id
      t.string :word
      t.timestamps null: false
    end
    add_index :ppomppu_freeboard_words, [:sns_content_id, :word], unique: true
    add_index :ppomppu_freeboard_words, :created_at
  end
end
