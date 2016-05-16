class AddPushOffTimeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_push_off_time, :boolean, default: false
    add_column :users, :push_off_start_time, :time
    add_column :users, :push_off_end_time, :time
    add_index :users, [:is_push_off_time, :push_off_start_time, :push_off_end_time], :name => 'push_off_time_index'
  end
end
