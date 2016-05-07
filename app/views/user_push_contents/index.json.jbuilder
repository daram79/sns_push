json.array!(@user_push_contents) do |user_push_content|
  json.extract! user_push_content, :id
  json.url user_push_content_url(user_push_content, format: :json)
end
