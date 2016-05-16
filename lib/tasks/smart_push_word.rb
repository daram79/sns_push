#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

while 1
  begin
    sns_content = SnsContent.where(sns_id: 1).last
    next unless sns_content
    smart_word = SmartPushWord.where(sns_content_id: sns_content.id).first
    unless smart_word
      SmartPushWord.create(sns_content_id: sns_content.id, word: sns_content.title)
    end
  rescue => e
    p e.message
  end
end

