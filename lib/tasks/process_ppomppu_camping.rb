#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'

while 1
  begin
    first_content_id = ""
    sns_id = 21
    head_url = "http://www.ppomppu.co.kr/zboard/"
    
    tmp = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    url = "http://www.ppomppu.co.kr/zboard/zboard.php?id=camping&a=#{tmp}"
    default_url = "http://www.ppomppu.co.kr/zboard/view.php?id=camping&no="
    
    html_str = open(url, "r:UTF-8").read
    html_str.force_encoding("euc-kr")
    html_str.scrub!('?')
    html = html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
    doc = Nokogiri::HTML(html)
    
    items = doc.css("#revolution_main_table tr")
    items.each do |item|
      begin
        next if ("list0" != item.attr("class")) && ("list1" != item.attr("class"))
        content_id = item.css("td")[3].css("a").attr("href").value.split("=")[-1]
        first_content_id = content_id if first_content_id == ""
        
        search_ret = SnsContent.where(sns_id: sns_id, content_id: content_id)
        break unless search_ret.blank?
        
        title = item.css("td")[3].css("a").text
        link_url = head_url + item.css("td")[3].css("a").attr("href").value
        insert_url = default_url + content_id
        
        
        con_html_str = open(link_url, "r:UTF-8").read
        con_html_str.force_encoding("euc-kr")
        con_html_str.scrub!('?')
        con_html = con_html_str.force_encoding("UTF-8").encode("utf-8", "euc-kr")
        con_doc = Nokogiri::HTML(con_html)
        
        description = con_doc.css("#realArticleView").text
        SnsContent.create(sns_id: sns_id, content_id: content_id, title: title, url: insert_url, description: description)
      rescue
      end
    end
    
    # content_id = items[5].css("td")[3].css("td")[1].css("a").attr("href").value.split("=")[-1]
    for i in 1..10
      begin
        new_id = first_content_id.to_i + 1
        content_id = new_id.to_s
        link_url = default_url + content_id
          
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
            insert_url = default_url + content_id
            SnsContent.create(sns_id: sns_id, content_id: content_id, title: title, url: insert_url, description: description) 
          end
        end
      rescue
      end
    end
    
  rescue => e
    p e.backtrace
  end
end
