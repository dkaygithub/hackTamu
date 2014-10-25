json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :rating, :college_id
  json.url college_venue_url(@college,venue, format: :json)
end
