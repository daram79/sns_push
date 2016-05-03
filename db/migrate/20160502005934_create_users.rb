class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text    :registration_id
      t.boolean :is_push, default: true
      t.timestamps null: false
    end
  end
end
