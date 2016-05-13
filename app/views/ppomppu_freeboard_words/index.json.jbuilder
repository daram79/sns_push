json.array!(@ppomppu_freeboard_words) do |ppomppu_freeboard_word|
  json.extract! ppomppu_freeboard_word, :id
  json.url ppomppu_freeboard_word_url(ppomppu_freeboard_word, format: :json)
end
