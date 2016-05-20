json.array!(@smart_push_lists) do |smart_push_list|
  json.extract! smart_push_list, :id
  json.url smart_push_list_url(smart_push_list, format: :json)
end
