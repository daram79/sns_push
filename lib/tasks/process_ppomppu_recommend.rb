#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'

while 1
  begin
    sns_id = 1
    head_url = "http://www.ppomppu.co.kr/zboard/"
    
    tmp = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    url = "http://www.ppomppu.co.kr/zboard/zboard.php?id=freeboard&a=#{tmp}"
    
    html_str = open(url, "r:UTF-8").read
    html_str.force_encoding("euc-kr")
    html_str.scrub!('?')
    html = html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
    doc = Nokogiri::HTML(html)
    
    items = doc.css("#revolution_main_table tr")
    items.each do |item|
      begin
        next if "page_show_noti_1".eql?(item.attr("id"))
        next unless item.attr("class")
        content_id = item.css("td")[2].css("a").attr("href").value.split("=")[-1]
        
        comment_count = 0
        recommend_count = 0
        comment_count = item.css("td")[2].css(".list_comment2").text.to_i
        # if comment_count > 0 && item.css("td")[4].text != ""
          recommend_count = item.css("td")[4].text.split(" - ")[0].to_i
          # if recommend_count > 0
            recommend_data = SnsContent.where(sns_id: sns_id, content_id: content_id).first
            if recommend_data && (comment_count > recommend_data.comment_count || recommend_count > recommend_data.recommend_count)
              recommend_data.update(recommend_count: recommend_count, comment_count: comment_count)
            end 
          # end
        # end
        
        # comment_count = item.css("td")[2].css(".list_comment2").text.to_i
        # if comment_count > 0 && item.css("td")[4].text != ""
          # recommend_count = item.css("td")[4].text.split(" - ")[0].to_i
          # if recommend_count > 0
            # recommend_data = SnsContent.where(sns_id: sns_id, content_id: content_id).first
            # if recommend_data && (comment_count > recommend_data.comment_count || recommend_count > recommend_data.recommend_count)
              # recommend_data.update(recommend_count: recommend_count, comment_count: comment_count)
            # end 
          # end
        # end
      rescue
      end
    end    
  rescue => e
    p e.backtrace
  end
  sleep 1
end





