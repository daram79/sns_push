class CreateMainMenus < ActiveRecord::Migration
  def change
    create_table :main_menus do |t|
      t.string  :name
      t.integer :index
      t.integer :menu_type
      t.timestamps null: false
    end
  end
end
