class AddCommentCountToSnsContents < ActiveRecord::Migration
  def change
    add_column :sns_contents, :comment_count, :integer, default: 0
    add_index :sns_contents, [:recommend_count, :comment_count]
  end
end
