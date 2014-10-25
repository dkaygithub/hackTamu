json.array!(@colleges) do |college|
  json.extract! college, :id, :name
  json.url college_url(college, format: :json)
end
