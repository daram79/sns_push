#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

while 1
  begin
    comment_push_list = CommentPushList.where(is_push: true).first
    next unless comment_push_list
    user_id = comment_push_list.user_id
    
# push on/off
#     에티켓
    t = Time.now
    search_time = "#{t.hour}:#{t.min}:#{t.sec}"
    # user_ids = User.where("is_push_off_time = ? or (push_off_start_time > ? and push_off_end_time < ?) and id = ?", false, search_time, search_time, user_id).pluck(:id)
    user_ids = User.where("is_push = ? and (is_push_off_time = ? or push_off_start_time > ? or push_off_end_time < ?) and id = ?", true, false, search_time, search_time, user_id).pluck(:id)
      
    sns_id = comment_push_list.sns_content.sns_id
    title = comment_push_list.sns_content.title
    url = comment_push_list.sns_content.url
      
    CommentPushList.send_push(user_ids, sns_id, title, url)
    
    comment_push_list.update(is_push: false)
  rescue => e
    p e.message
    comment_push_list.update(is_push: false)
  end
end

