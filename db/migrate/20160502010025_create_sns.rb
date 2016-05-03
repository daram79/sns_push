class CreateSns < ActiveRecord::Migration
  def change
    create_table :sns do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
