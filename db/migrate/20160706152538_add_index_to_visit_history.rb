class AddIndexToVisitHistory < ActiveRecord::Migration
  def change
    add_index :visit_histories, :url
    add_index :visit_histories, [:url, :created_at]
    remove_index :visit_histories, :title
    remove_index :visit_histories, [:title, :created_at]
  end
end


# VisitHistory.where("created_at > 2016-01-01").group(:url).order('count_url desc').count('url').keys