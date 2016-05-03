json.array!(@user_push_keys) do |user_push_key|
  json.extract! user_push_key, :id
  json.url user_push_key_url(user_push_key, format: :json)
end
