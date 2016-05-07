#encoding: utf-8
class UserPushKey < ActiveRecord::Base
  belongs_to :sns_push_key
end
