class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.text :description
      t.boolean :is_show, default: false
      t.timestamps null: false
    end
    add_index :notices, :is_show
  end
end
