class SmartPushWord < ActiveRecord::Base
  def self.add_data(sns_content_id, title, description)
    title.delete!('"')
    description.delete!('"')
    description.gsub!(/(\r\n|\r|\n)/, " ")
    description.gsub!("\u00A0", "")
    
    
    title_ary = title.split(" ")
    # title_ary.delete!(" ")
    
    description_ary = description.split(" ")
    # description_ary.delete!(" ")
    
    ActiveRecord::Base.transaction do
      title_ary.each do |t|
        begin
          SmartPushWord.create(sns_content_id: sns_content_id, word: t) if t.strip! != ""
        rescue
        end
      end
      description_ary.each do |d|
        begin
          SmartPushWord.create(sns_content_id: sns_content_id, word: d) if d.strip! != ""
        rescue
        end
      end
      
    end
  end
  
  def self.send_push(user_ids, title)
    url = "http://m.ppomppu.co.kr/new/bbs_list.php?id=freeboard"
    gcm = GCM.new("AIzaSyA5xAh3R864Qp0PNr5zfdwxc4JdYzbG734")
    registration_ids = User.where(id: user_ids).pluck(:registration_id)
    option = { :data => { 'message' => "#{title} ***#{url} ***smart_push" } }   
    
    registration_ids.uniq!
    registration_ids.delete(nil)
    unless registration_ids.blank?
      begin
        response = gcm.send(registration_ids, option)
#         여기에서 푸쉬 실패 처리
        self.push_check(response, registration_ids, title, url)
      rescue => e
        pp e.backtrace
      end
    end
  end
  
  def self.push_check(response, registration_ids, title, url)
    loop_flg = true
    loop_flg = false if JSON.parse(response[:body])["failure"] == 0
    while loop_flg
      rr = JSON.parse(response[:body])["results"]
      
      delete_ids = response[:not_registered_ids]
      update_ids = []
      success_ids = []
      
      rr.each_with_index do |r, i|
        update_hash = Hash.new
        if r.key?("error") && r.value?("NotRegistered")
          delete_ids.push registration_ids[i]
        elsif r.key?("error") && r.value?("InvalidRegistration")
          delete_ids.push registration_ids[i]
        elsif r.key?("message_id") && r.key?("registration_id")
          update_hash[:old] = registration_ids[i]
          update_hash[:new] = r["registration_id"]
          update_ids.push(update_hash)
          # delete_id_index.push i
        elsif r.key?("error") && r.value?("Unavailable")
          #전송 실패한 아이디는 다시 전송
        elsif r.key?("message_id") && r.size == 1
          success_ids.push registration_ids[i]
          # update_id_index.push i
        end
      end
          
      #푸쉬에 성공한 registration_id 배열에서 삭제함.
      success_ids.each do |success_id|
        i = registration_ids.index(success_id)
        registration_ids.delete_at(i)
      end
      
      
      #잘못된 registration_id DB에서 삭제
      del_event_registrations = User.where(registration_id: delete_ids)
      del_event_registrations.update_all(registration_id: nil)
      
      
      #잘못된 registration_id 배열에서 삭제
      delete_ids.each do |del_id|
        i = registration_ids.index(del_id)
        registration_ids.delete_at(i)
      end
      
      #변경된 registration_id 배열/DB에서 업데이트
      update_ids.each do |up_id|
        i = registration_ids.index(up_id[:old])
        registration_ids[i] = up_id[:new]
        up_event_registrations = User.find_by_registration_id(up_id[:old])
        up_event_registrations.update(registration_id: up_id[:new])
      end
      unless registration_ids.blank?
        response, registration_ids = self.re_send_push(registration_ids, title, url)
        loop_flg = false if JSON.parse(response[:body])["failure"] == 0
      else
        loop_flg = false
      end
    end
  end
  
  def self.re_send_push(registration_ids, title, url)
    gcm = GCM.new("AIzaSyA5xAh3R864Qp0PNr5zfdwxc4JdYzbG734")
    option = { :data => { 'message' => "#{title} ***#{url} ***smart_push" } }
    response = gcm.send(registration_ids, option)
    return response, registration_ids
  end
  
  
end
