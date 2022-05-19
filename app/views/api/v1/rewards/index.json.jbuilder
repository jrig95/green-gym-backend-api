json.array! @rewards do |reward|
  json.extract! reward, :id, :reward_name, :reward_points, :program_id, :visible

  if reward.photo.attached?
    # json.photo_url url_for(@program.photo)
    json.photo_url reward.photo.service_url
    # json.photo_url @program.photo.public_url
  end
end
