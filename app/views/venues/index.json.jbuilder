json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :rating, :college_id
  json.url venue_url(venue, format: :json)
end
