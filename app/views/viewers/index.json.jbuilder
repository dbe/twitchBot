json.array!(@viewers) do |viewer|
  json.extract! viewer, :id, :name
  json.url viewer_url(viewer, format: :json)
end
