#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

day = Date.yesterday.yesterday.to_s
user_push_content = UserPushContent.where("created_at < ?", day)
user_push_content.destroy_all


day = Date.yesterday
smart_push_word = SmartPushWord.where("created_at < ?", day)
smart_push_word.destroy_all