class CreateVisitHistories < ActiveRecord::Migration
  def change
    create_table :visit_histories do |t|
      t.integer :user_id
      t.string  :url
      t.string  :title
      t.boolean :is_delete, default: false
      t.timestamps null: false
    end
    add_index :visit_histories, :user_id
    add_index :visit_histories, :title
    add_index :visit_histories, [:user_id, :is_delete]
    add_index :visit_histories, [:user_id, :url]
  end
end
