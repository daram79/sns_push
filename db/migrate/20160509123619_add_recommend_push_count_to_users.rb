class AddRecommendPushCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recommend_push_count, :integer, default: nil
    add_index :users, :recommend_push_count
  end
end
