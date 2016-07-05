class CreateVisitHistories < ActiveRecord::Migration
  def change
    create_table :visit_histories do |t|
      t.integer :user_id
      t.string  :url
      t.timestamps null: false
    end
    add_index :visit_histories, [:user_id, :url]
  end
end
