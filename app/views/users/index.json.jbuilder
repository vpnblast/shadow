json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :date_begin, :date_end, :email
  json.url user_url(user, format: :json)
end
