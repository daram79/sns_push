class CreateSnsContents < ActiveRecord::Migration
  def change
    create_table :sns_contents do |t|
      t.integer :sns_id
      t.integer :content_id, :limit => 5
      t.string  :title
      t.string  :url
      t.text    :description
      t.boolean :is_push
      t.timestamps null: false
    end
    add_index :sns_contents, :title
    add_index :sns_contents, :description, :length => 10
  end
end
