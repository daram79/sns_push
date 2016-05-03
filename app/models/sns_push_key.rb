class SnsPushKey < ActiveRecord::Base
  has_many :user_push_keys
end
