class AddPushListIdToUserPushContents < ActiveRecord::Migration
  def change
    add_column :user_push_contents, :push_list_id, :integer
    add_index :user_push_contents, :push_list_id
  end
end
