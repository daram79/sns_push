class AddWriterToUsersAndSnsContents < ActiveRecord::Migration
  def change
    add_column :users, :nick_name, :string
    add_column :users, :is_push_comment, :boolean
    add_column :sns_contents, :writer, :string
    add_index :sns_contents, :writer
    add_index :users, [:nick_name, :is_push_comment]
    add_index :users, :nick_name
  end
end
