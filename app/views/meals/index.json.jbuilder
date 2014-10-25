json.array!(@meals) do |meal|
  json.extract! meal, :id, :name, :venue_id
  json.url meal_url(meal, format: :json)
end
