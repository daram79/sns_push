class User < ActiveRecord::Base
  has_many :user_push_contents
  has_many :user_keyword_modes
  has_many :visit_histories
end
