class AddRecommendCountToSnsContents < ActiveRecord::Migration
  def change
    add_column :sns_contents, :recommend_count, :integer, default: 0
  end
end
