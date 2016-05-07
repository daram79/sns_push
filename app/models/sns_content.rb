class SnsContent < ActiveRecord::Base
  has_many :user_push_contents
  
  after_create :create_user_push_data
  
  def create_user_push_data
    sns_id = self.sns_id
    title = self.title
    description = self.description
    url = self.url
    
    key_ids = []
    push_datas = SnsPushKey.where(sns_id: sns_id)
    push_datas.each do |push_data|
      if title.include?(push_data.key)
        key_ids.push push_data.id
      elsif description.include?(push_data.key)
        key_ids.push push_data.id 
      end
    end
    key_ids.uniq!
    user_ids = UserPushKey.where(sns_push_key_id: key_ids).pluck(:user_id)
    ActiveRecord::Base.transaction do
      user_ids.each do |user_id|
        UserPushContent.create(sns_content_id: self.id, user_id: user_id)
      end
    end
    UserPushContent.send_push(user_ids, sns_id, title, url)
  end
  
end
