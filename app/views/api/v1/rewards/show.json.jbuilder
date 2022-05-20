json.extract! @reward, :id, :reward_name, :reward_points, :program_id, :visible
# json.programs @reward.programs do |program|
  # json.extract! program, :program_title, :program_description
# end
if @reward.photo.attached?
  json.photo_url @reward.photo.service_url
end
