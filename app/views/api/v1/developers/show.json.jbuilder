json.(@developer, :first_name, :last_name, :email, :full_name, :github_username)
json.cohort do
  json.name @developer.cohort.name
  json.version @developer.cohort.version
  json.units @developer.cohort.units do |unit|
    json.index unit.index
    json.start_at unit.start_at
    json.end_at unit.end_at
  end
end
