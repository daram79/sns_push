#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

while 1
  begin
    push_list = PushList.where(is_push: true).first
    next unless push_list
    user_push_contents = push_list.user_push_contents
    push_list.destroy if user_push_contents.blank?
    user_ids = []
    user_push_contents.each do |user_push_content|
      user_ids.push user_push_content.user_id
    end
    unless user_ids.blank?
      user_ids = [1] #for test
      sns_id = user_push_contents[0].sns_content.sns_id
      title = user_id = user_push_contents[0].sns_content.title
      url = user_push_contents[0].sns_content.url
      
      UserPushContent.send_push(user_ids, sns_id, title, url, push_list.is_recommend)
      push_list.update(is_push: false)
    end
  rescue => e
    p e.message
    push_list.update(is_push: false, is_error: true)
  end
end

