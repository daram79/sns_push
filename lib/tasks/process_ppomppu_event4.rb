#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'

while 1
  begin
    sns_id = 4
    head_url = "http://www.ppomppu.co.kr/zboard/"
    
    tmp = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    url = "http://www.ppomppu.co.kr/zboard/zboard.php?id=ppomppu4&a=#{tmp}"
    
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
        # content_id = item.css("td")[2].css("a").attr("href").value.split("=")[-1]
        content_id = item.css("td")[3].css("td")[1].css("a").attr("href").value.split("=")[-1]
        
        search_ret = SnsContent.where(sns_id: sns_id, content_id: content_id)
        
        # title = item.css("td")[2].css("a").text
        title = item.css("td")[3].css("td")[1].css("a").text
        
        
        # if item.css("td")[7].text != ""
          # recommend = item.css("td")[7].text.split(" - ")[0]
          # #추천수로 푸쉬
        # end
        
        break unless search_ret.blank?
        
        # link_url = head_url + item.css("td")[2].css("a").attr("href").value
        link_url = head_url + item.css("td")[3].css("td")[1].css("a").attr("href").value
        
        
        
        con_html_str = open(link_url, "r:UTF-8").read
        con_html_str.force_encoding("euc-kr")
        con_html_str.scrub!('?')
        con_html = con_html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
        con_doc = Nokogiri::HTML(con_html)
        
        description = con_doc.css("#realArticleView").text
        SnsContent.create(sns_id: sns_id, content_id: content_id, title: title, url: link_url, description: description)
        # UserPushKey.send_push(sns_id, title, description, link_url)
      rescue
      end
    end
    
    
    content_id = items[3].css("td")[3].css("td")[1].css("a").attr("href").value.split("=")[-1]
    for i in 1..10
      begin
        new_id = content_id.to_i + 1
        content_id = new_id.to_s
        link_url = "http://www.ppomppu.co.kr/zboard/view.php?id=ppomppu4&no=#{content_id}"
          
        search_ret = SnsContent.where(sns_id: sns_id, content_id: content_id)
        if search_ret.blank?
          
          con_html_str = open(link_url, "r:UTF-8").read
          con_html_str.force_encoding("euc-kr")
          con_html_str.scrub!('?')
          con_html = con_html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
          con_doc = Nokogiri::HTML(con_html)
          
          description = con_doc.css("#realArticleView").text
          title = con_doc.css(".view_title2").text
          
          break if description == "" && title == ""
          
          if title != "" || title != ""
            SnsContent.create(sns_id: sns_id, content_id: content_id, title: title, url: link_url, description: description) 
            # UserPushKey.send_push(sns_id, title, description, link_url)
          end
        end
      rescue
      end
    end
    
  rescue => e
    p e.backtrace
  end
end
