json.array!(@sns_contents) do |sns_content|
  json.extract! sns_content, :id
  json.url sns_content_url(sns_content, format: :json)
end
