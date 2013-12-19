json.array!(@cams) do |cam|
  json.extract! cam, :id, :location, :longitude, :latitude, :uri
  json.url cam_url(cam, format: :json)
end
