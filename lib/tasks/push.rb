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
#     
      if push_list.is_recommend
        test_user_id = []
        user_ids.each do |user_id|
          if user_id.to_i == 1
            test_user_id.push user_id
          end
        end
        user_ids = test_user_id
      end
# 

# push on/off
#     에티켓
      t = Time.now
      search_time = "#{t.hour}:#{t.min}:#{t.sec}"
      del_user_ids = User.where("is_push_off_time = ? and push_off_start_time < ? and push_off_end_time > ?", true, search_time, search_time).pluck(:id)
      
#     알람off
      del_user_ids2 = User.where(is_push: false).pluck(:id)
      
      user_ids = user_ids - del_user_ids - del_user_ids2


# push on/off
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

