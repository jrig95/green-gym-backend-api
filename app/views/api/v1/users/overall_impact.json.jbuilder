json.array! @users do |user|
  json.extract! user, :id, :first_name,:user_total_calories

  if user.photo.attached?
    json.photo_url user.photo.service_url
  end

end
