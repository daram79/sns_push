class PpomppuFreeboardWord < ActiveRecord::Base
  
  # def self.add_data(sns_content_id, title, description)
    # title.delete!('"')
    # description.delete!('"')
    # description.gsub!(/(\r\n|\r|\n)/, " ")
    # description.gsub!("\u00A0", "")
#     
#     
    # title_ary = title.split(" ")
    # # title_ary.delete!(" ")
#     
    # description_ary = description.split(" ")
    # # description_ary.delete!(" ")
#     
    # ActiveRecord::Base.transaction do
      # title_ary.each do |t|
        # begin
          # PpomppuFreeboardWord.create(sns_content_id: sns_content_id, word: t) if t.strip! != ""
        # rescue
        # end
      # end
      # description_ary.each do |d|
        # begin
          # PpomppuFreeboardWord.create(sns_content_id: sns_content_id, word: d) if d.strip! != ""
        # rescue
        # end
      # end
#       
    # end
  # end
  
    
        
end
