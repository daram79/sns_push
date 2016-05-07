class User < ActiveRecord::Base
  has_many :user_push_contents
end
