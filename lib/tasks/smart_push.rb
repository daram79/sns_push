#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

now = Time.now
smart_push_words = SmartPushWord.where('created_at > ?', now.ago(60)).group('word').order('count_id desc').count('id')

smart_push_words.each do |key, value|
  if value > 4
    add_datas = SmartPushWord.where('created_at > ?', now.ago(60)).where(word: smart_push_words.key)
    add_datas.each do |data|
      SmartPushList.create(sns_content_id: data.sns_content_id)
    end
    #대란 확실시
    SmartPushWord.send_push(1, "대란 확실시됨")
  elsif value > 2
    add_datas = SmartPushWord.where('created_at > ?', now.ago(60)).where(word: smart_push_words.key)
    add_datas.each do |data|
      SmartPushList.create(sns_content_id: data.sns_content_id)
    end
    #대란 가능성
    SmartPushWord.send_push(1, "대란 가능성 있음")
  end
  break
end
  