class UserPushKey < ActiveRecord::Base
  belongs_to :sns_push_key
  
  def self.send_push(title, description, link_url)
    key_ids = []
    push_datas = SnsPushKey.all
    push_datas.each do |push_data|
      key_ids.push push_data.id if title.include?(push_data.key)
      key_ids.push push_data.id if description.include?(push_data.key)
    end
    
    user_ids = UserPushKey.where(sns_push_key_id: key_ids).pluck(:user_id)
    gcm = GCM.new("AIzaSyA5xAh3R864Qp0PNr5zfdwxc4JdYzbG734")
    registration_ids = User.where(id: user_ids).pluck(:registration_id)
    option = { :data => { 'message' => "#{title} ***#{link_url}" } }   
    
    registration_ids.uniq!
    unless registration_ids.blank?
      begin
        response = gcm.send(registration_ids, option)
#         여기에서 푸쉬 실패 처리
      rescue => e
        pp e.backtrace
      end
    end
  end
end
