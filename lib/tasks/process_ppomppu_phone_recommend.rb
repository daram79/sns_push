#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'

while 1
  begin
    sns_id = 11
    head_url = "http://www.ppomppu.co.kr/zboard/"
    
    tmp = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    url = "http://www.ppomppu.co.kr/zboard/zboard.php?id=phone&a=#{tmp}"
    
    html_str = open(url, "r:UTF-8").read
    html_str.force_encoding("euc-kr")
    html_str.scrub!('?')
    html = html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
    doc = Nokogiri::HTML(html)
    
    items = doc.css("#revolution_main_table tr")
    items.each do |item|
      begin
        next if "page_show_noti_1".eql?(item.attr("id"))
        next if "page_show_noti_2".eql?(item.attr("id"))
        next unless item.attr("class")
        content_id = item.css("td")[3].css("a").attr("href").value.split("=")[-1]
        if item.css("td")[5].text != ""
          recommend = item.css("td")[5].text.split(" - ")[0].to_i
          if recommend > 0
            recommend_data = SnsContent.where(sns_id: sns_id, content_id: content_id).first
            if recommend_data && recommend > recommend_data.recommend_count
              recommend_data.update(recommend_count: recommend)
            end 
          end
        end
      rescue
      end
    end    
  rescue => e
    p e.backtrace
  end
  sleep 1
end
