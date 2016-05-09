class UserPushContent < ActiveRecord::Base
  belongs_to :sns_content
  belongs_to :user
  
  # after_commit :send_push, on: :create
  
  def self.send_push(user_ids, sns_id, title, url, is_recommend=false)
    categori_str = "[자게]"
    categori_str = "[뽐게]" if sns_id == 2
    categori_str = "[해뽐]" if sns_id == 4
    if is_recommend
    categori_str = "[추천]" + categori_str  
    end
    gcm = GCM.new("AIzaSyA5xAh3R864Qp0PNr5zfdwxc4JdYzbG734")
    registration_ids = User.where(id: user_ids).pluck(:registration_id)
    option = { :data => { 'message' => "#{categori_str} #{title} ***#{url}" } }   
    
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
