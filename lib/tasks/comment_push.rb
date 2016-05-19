#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'

while 1
  begin
    send_flg = false
    comment_push_list = CommentPushList.where(is_push: true).first
    next unless comment_push_list

    user_id = comment_push_list.user_id
    
    url = comment_push_list.sns_content.url
    html_str = open(url, "r:UTF-8").read
    html_str.force_encoding("euc-kr")
    html_str.scrub!('?')
    html = html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
    doc = Nokogiri::HTML(html)
    comments = doc.css(".cmAr")
    total_comment_count = comments.to_s.scan(/<table/).length
    my_comment_count = html.scan(/f7f7f7/).length
    another_comment_count  = total_comment_count - my_comment_count
    comment_push_list.update(total_comment_count: total_comment_count, my_comment_count: my_comment_count, another_comment_count: another_comment_count)
    

#   이전 데이터가 있는지 확인    
    check_data = CommentPushList.where(is_push: false, user_id: comment_push_list.user_id, sns_content_id: comment_push_list.sns_content_id).last
    unless check_data
      send_flg = true
    else
      if another_comment_count > check_data.another_comment_count
        send_flg = true
      end 
    end
    
    if send_flg
      # push on/off
      # 에티켓
      t = Time.now
      search_time = "#{t.hour}:#{t.min}:#{t.sec}"
      # user_ids = User.where("is_push_off_time = ? or (push_off_start_time > ? and push_off_end_time < ?) and id = ?", false, search_time, search_time, user_id).pluck(:id)
      user_ids = User.where("is_push = ? and (is_push_off_time = ? or push_off_start_time > ? or push_off_end_time < ?) and id = ?", true, false, search_time, search_time, user_id).pluck(:id)
        
      sns_id = comment_push_list.sns_content.sns_id
      title = comment_push_list.sns_content.title
      url = comment_push_list.sns_content.url
        
      CommentPushList.send_push(user_ids, sns_id, title, url)
    end
    
    comment_push_list.update(is_push: false)
  rescue => e
    p e.message
    comment_push_list.update(is_push: false)
  end
end

