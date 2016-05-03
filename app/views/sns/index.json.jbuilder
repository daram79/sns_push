json.array!(@sns) do |sn|
  json.extract! sn, :id, :name
  json.url sn_url(sn, format: :json)
end
