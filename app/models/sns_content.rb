class SnsContent < ActiveRecord::Base
  has_many :user_push_contents
  has_many :comment_push_lists
  has_many :smart_push_lists
  
  after_create :create_user_push_data
  
  after_update :create_user_recommend_push_data
  
  def create_user_push_data
    sns_id = self.sns_id
    title = self.title
    description = self.description
    url = self.url
    
#     원하는 사람만 내용검색함. 기본 제목+내용
    title_key_ids = []
    description_key_ids = []
    push_datas = SnsPushKey.where(sns_id: sns_id)
    push_datas.each do |push_data|
      if title.downcase.include?(push_data.key.downcase)
        title_key_ids.push push_data.id
      elsif description.downcase.include?(push_data.key.downcase)
        description_key_ids.push push_data.id
      end
    end
#     제목으로 매칭된 키워드를 입력한 user_id 추출
    title_user_ids = UserPushKey.where(sns_push_key_id: title_key_ids).pluck(:user_id)

#     내용으로 매칭된 키워드를 입력한 user_id 추출    
    description_user_ids = UserPushKey.where(sns_push_key_id: description_key_ids).pluck(:user_id)
    
#     제목으로만 매칭을 원하는 user_id 추출
    title_only_user_ids = UserKeywordMode.where(only_title: true, sns_id: sns_id).pluck(:user_id)
    description_user_ids = description_user_ids - title_only_user_ids
    
    user_ids = title_user_ids + description_user_ids
    user_ids.uniq!
    
    # key_ids.uniq!
    # user_ids = UserPushKey.where(sns_push_key_id: key_ids).pluck(:user_id)
    # user_ids.uniq!
    
    
    
    
    
    
    
    
    
    
#     제목/내용 모두 검색
    # key_ids = []
    # push_datas = SnsPushKey.where(sns_id: sns_id)
    # push_datas.each do |push_data|
      # if title.downcase.include?(push_data.key.downcase)
        # key_ids.push push_data.id
      # elsif description.downcase.include?(push_data.key.downcase)
        # key_ids.push push_data.id 
      # end
    # end
    # key_ids.uniq!
    # user_ids = UserPushKey.where(sns_push_key_id: key_ids).pluck(:user_id)
    # user_ids.uniq!
    
    push_list = PushList.create
    
    ActiveRecord::Base.transaction do
      user_ids.each do |user_id|
        begin
          user_push_content = UserPushContent.create(sns_content_id: self.id, user_id: user_id, push_list_id: push_list.id)
        rescue
        end
      end
    end
    # UserPushContent.send_push(push_user_ids, sns_id, title, url) unless push_user_ids.blank?
    # PpomppuFreeboardWord.add_data(self.id, title, description) if sns_id == 1
    # SmartPushWord.add_data(self.id, title, description) if sns_id == 1
  end
  
  def create_user_recommend_push_data
    # sns_content_id = self.id
    sns_id = self.sns_id
    title = self.title
    description = self.description
    url = self.url
    recommend_count = self.recommend_count
    comment_count = self.comment_count
    
    user_ids = []
    
    comment_count = comment_count == 0 ? 0 : comment_count + 1 
    recommend_count = recommend_count == 0 ? 0 : recommend_count + 1
    
    if sns_id.to_i == 1
      
#     댓글 푸시 start
begin
      if self.writer != nil
        users = User.where(is_push_comment: true, nick_name: self.writer)
          users.each do |user|
            CommentPushList.create(user_id: user.id, sns_content_id: self.id)
          end
        #end
      end
rescue
end
#     댓글 푸시 end
      
      
      comment_user_ids = CommentPushCount.where(sns_id: sns_id).where("count < ?", comment_count).pluck(:user_id)
      recommend_user_ids = RecommendPushCount.where(sns_id: sns_id).where("count < ?", recommend_count).pluck(:user_id)
      user_ids = comment_user_ids & recommend_user_ids
    else
      user_ids = RecommendPushCount.where(sns_id: sns_id).where("count < ?", recommend_count).pluck(:user_id)
    end
    
    # user_ids = User.where("recommend_push_count < ?", recommend_count+1).pluck(:id)
    unless user_ids.blank?
      del_user_ids = self.user_push_contents.pluck(:user_id)
      user_ids = user_ids - del_user_ids
      push_list = PushList.create(is_recommend: true)

      ActiveRecord::Base.transaction do
        user_ids.each do |user_id|
          begin
            user_push_content = UserPushContent.create(sns_content_id: self.id, user_id: user_id, push_list_id: push_list.id)
          rescue
          end
        end
      end
      # recommend = true
      # UserPushContent.send_push(push_user_ids, sns_id, title, url, recommend) unless push_user_ids.blank?
    end
  end
end
