json.array!(@sns_push_keys) do |sns_push_key|
  json.extract! sns_push_key, :id
  json.url sns_push_key_url(sns_push_key, format: :json)
end
