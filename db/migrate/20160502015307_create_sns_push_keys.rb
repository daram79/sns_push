class CreateSnsPushKeys < ActiveRecord::Migration
  def change
    create_table :sns_push_keys do |t|
      t.integer :sns_id
      t.string :key
      t.timestamps null: false
    end
    add_index :sns_push_keys, [:sns_id, :key]
  end
end
