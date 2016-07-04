class CreateUserKeywordModes < ActiveRecord::Migration
  def change
    create_table :user_keyword_modes do |t|
      t.integer :user_id
      t.integer :sns_id
      t.boolean :only_title, default: false
      t.timestamps null: false
    end
    add_index :user_keyword_modes, [:sns_id, :only_title]
    add_index :user_keyword_modes, [:user_id, :sns_id]
    add_index :user_keyword_modes, :user_id
  end
end
