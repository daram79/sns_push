json.array!(@sns) do |sn|
  json.extract! sn, :id
  json.url sn_url(sn, format: :json)
end
